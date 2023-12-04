import unittest
import urllib.request
import json

URL_PASTEIS = "http://localhost:5001/pasteis"
URL_PASTEL = "http://localhost:5001/pastel"

TAMANHO_DA_PAGINA = 4
NOME_DO_PASTEL = "frango"

class TestePasteis(unittest.TestCase):

    def acessar(self, url):
        resposta = urllib.request.urlopen(url)
        dados = resposta.read()
        return dados.decode("utf-8")
        
    def testar_01_lazy_loading(self):
        dados = self.acessar(f"{URL_PASTEIS}/1/{TAMANHO_DA_PAGINA}")
        pasteis = json.loads(dados)

        self.assertEqual(len(pasteis), TAMANHO_DA_PAGINA)
        self.assertEqual(pasteis[0]['pastel_id'], 1)

    def testar_02_pesquisa_pastel_pelo_id(self):
        dados = self.acessar(f"{URL_PASTEL}/1")
        pastel = json.loads(dados)

        self.assertEqual(pastel['pastel_id'], 1)

    def testar_03_pesquisa_pastel_pelo_nome(self):
        dados = self.acessar(f"{URL_PASTEIS}/1/{TAMANHO_DA_PAGINA}/{NOME_DO_PASTEL}")
        pasteis = json.loads(dados)

        for pastel in pasteis:
            self.assertIn(NOME_DO_PASTEL, pastel['nome_pastel'].lower())