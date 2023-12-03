from flask import Flask, jsonify
from urllib.request import urlopen
import mysql.connector as mysql
import json

servico = Flask("pasteis")

SERVIDOR_BANCO = "banco"
USUARIO_BANCO = "root"
SENHA_BANCO = "admin"
NOME_BANCO = "pastelaria"

def get_conexao_com_bd():
    conexao = mysql.connect(host=SERVIDOR_BANCO, user=USUARIO_BANCO, password=SENHA_BANCO, database=NOME_BANCO)

    return conexao


URL_LIKES = "http://likes:5000/likes_por_feed/"
def get_quantidade_de_curtidas(id_do_feed):
    url = URL_LIKES + str(id_do_feed)
    resposta = urlopen(url)
    resposta = resposta.read()
    resposta = json.loads(resposta)

    return resposta["curtidas"]

@servico.get("/info")
def get_info():
    return jsonify(
        descricao = "gerenciamento de pasteis",
        versao = "1.0"
    )

@servico.get("/pasteis/<int:pagina>/<int:tamanho_da_pagina>")
def get_pasteis(pagina, tamanho_da_pagina):
    pasteis = []

    conexao = get_conexao_com_bd()
    cursor = conexao.cursor(dictionary=True)
    cursor.execute(
        "SELECT feeds.id as pastel_id, DATE_FORMAT(feeds.data, '%Y-%m-%d %H:%i') as data, " +
        "pastelaria.id as pastelaria_id, pastelaria.nome as nome_pastelaria, pastelaria.avatar, pasteis.nome as nome_pastel, pasteis.descricao, FORMAT(pasteis.preco, 2) as preco, " +
        "pasteis.imagem1, IFNULL(pasteis.imagem2, '') as imagem2 " +
        "FROM feeds, pasteis, pastelaria " +
        "WHERE pasteis.id = feeds.pastel " +
        "AND pastelaria.id = pasteis.pastelaria " +
        "ORDER BY data asc " +
        "LIMIT " + str((pagina - 1) * tamanho_da_pagina) + ", " + str(tamanho_da_pagina)
    )
    pasteis = cursor.fetchall()
    if pasteis:
        for pastel in pasteis:
            pastel["curtidas"] = get_quantidade_de_curtidas(pastel['pastel_id'])

    conexao.close()

    return jsonify(pasteis)

@servico.get("/pasteis/<int:pagina>/<int:tamanho_da_pagina>/<string:nome_do_pastel>")
def find_pasteis(pagina, tamanho_da_pagina, nome_do_pastel):
    pasteis = []

    conexao = get_conexao_com_bd()
    cursor = conexao.cursor(dictionary=True)
    cursor.execute(
        "select feeds.id as pastel_id, DATE_FORMAT(feeds.data, '%Y-%m-%d %H:%i') as data, " +
        "pastelaria.id as pastelaria_id, pastelaria.nome as nome_pastelaria, pastelaria.avatar, pasteis.nome as nome_pastel, pasteis.descricao, FORMAT(pasteis.preco, 2) as preco, " +
        "pasteis.imagem1, IFNULL(pasteis.imagem2, '') as imagem2 "
        "FROM feeds, pasteis, pastelaria " +
        "WHERE pasteis.id = feeds.pastel " +
        "AND pastelaria.id = pasteis.pastelaria " +
        "AND pasteis.nome LIKE '%" + nome_do_pastel + "%' "  +
        "ORDER BY data desc " +
        "LIMIT " + str((pagina - 1) * tamanho_da_pagina) + ", " + str(tamanho_da_pagina)
    )
    pasteis = cursor.fetchall()
    if pasteis:
        for pastel in pasteis:
            pastel["curtidas"] = get_quantidade_de_curtidas(pastel['pastel_id'])

    conexao.close()

    return jsonify(pasteis)

@servico.get("/pastel/<int:id_do_feed>")
def find_pastel(id_do_feed):
    pastel = {}

    conexao = get_conexao_com_bd()
    cursor = conexao.cursor(dictionary=True)
    cursor.execute(
        "select feeds.id as pastel_id, DATE_FORMAT(feeds.data, '%Y-%m-%d %H:%i') as data, " +
        "pastelaria.id as pastelaria_id, pastelaria.nome as nome_pastelaria, pastelaria.avatar, pasteis.nome as nome_pastel, pasteis.descricao, FORMAT(pasteis.preco, 2) as preco, " +
        "pasteis.imagem1, IFNULL(pasteis.imagem2, '') as imagem2 " +
        "FROM feeds, pasteis, pastelaria " +
        "WHERE pasteis.id = feeds.pastel " +
        "AND pastelaria.id = pasteis.pastelaria " +
        "AND feeds.id = " + str(id_do_feed)
    )
    pastel = cursor.fetchone()
    if pastel:
        pastel["curtidas"] = get_quantidade_de_curtidas(id_do_feed)

    conexao.close()

    return jsonify(pastel)


if __name__ == "__main__":
    servico.run(host="0.0.0.0", debug=True)