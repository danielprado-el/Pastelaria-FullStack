import unittest
import urllib.request
import json

URL_LIKES = "http://localhost:5003/"

CONTA = "anonimo@gmail.com"

class TesteLikes(unittest.TestCase):

    def acessar(self, url):
        resposta = urllib.request.urlopen(url)
        dados = resposta.read()
        return dados.decode("utf-8")
    
    def enviar(self, url, metodo):
      requisicao = urllib.request.Request(url, method=metodo)
      resposta = urllib.request.urlopen(requisicao)
      dados = resposta.read()

      return dados.decode("utf-8")
    
    def testar_01_likes_por_pastel(self):
      dados = self.acessar(f"{URL_LIKES}/likes_por_feed/1")
      like = json.loads(dados)

      self.assertEqual(like['curtidas'], 1)

    def testar_02_curtiu(self):
      dados = self.acessar(f"{URL_LIKES}/curtiu/{CONTA}/1")
      like = json.loads(dados)

      self.assertEqual(like['curtiu'], True)


    def testar_03_curtir(self):
        resposta = self.enviar(f"{URL_LIKES}/curtir/{CONTA}/2", "POST")
        resposta = json.loads(resposta)

        self.assertEqual(resposta['situacao'], "ok")

        dados = self.acessar(f"{URL_LIKES}/curtiu/{CONTA}/2")
        dados = json.loads(dados)

        self.assertEqual(dados['curtiu'], True)

    def testar_04_descurtir(self):
        resposta = self.enviar(f"{URL_LIKES}/descurtir/{CONTA}/2", "POST")
        resposta = json.loads(resposta)

        self.assertEqual(resposta['situacao'], "ok")

        dados = self.acessar(f"{URL_LIKES}/curtiu/{CONTA}/2")
        dados = json.loads(dados)

        self.assertEqual(dados['curtiu'], False)
