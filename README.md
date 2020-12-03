# Cade esse CEP?

Sistema para buscar, através de um CEP válido, o endereço e um mapa de como chegar.

![Captura de tela de 2020-12-03 16-35-26](https://user-images.githubusercontent.com/15862643/101078933-94e6ac80-3585-11eb-8165-222ae7eccbca.png)

### Requisitos

**Não Funcionais**

- [ ]  A fonte de dados deve vir da [Brasil API](https://github.com/BrasilAPI/BrasilAPI)
- [ ]  Utilizar o OpenStreetMap como base para o mapa
    - [ ]  Exemplo de consulta [link](https://www.openstreetmap.org/search?query=Rua%20Doutor%20Area%20Le%C3%A3o%2C%20Nossa%20Senhora%20das%20Gra%C3%A7as%2C%20Teresina%2C%20Piau%C3%AD#map=18/-5.10163/-42.80288)
- [x]  O Projeto deve ser feito com Elixir e Phoenix

**Funcionais**

- [x]  O usuário deve poder digitar um CEP na caixa de texto
- [ ]  O usuário deve receber um alerta caso exista algum erro na busca
- [ ]  O usuário deve ser direcionado para a tela de informações caso tenha encontrado o endereço
- [ ]  Deve ser exibido um mapa para o usuário com a localização encontrada
- [ ]  Deve ser mostrado ao usuário o endereço encontrado segundo o protótipo

### Instalação do projeto

  Após o clone do projeto, certifique que o `Elixir` está instaldo corretamente na sua máquina, e também o `Phoenix`.

  > Caso não tenha o Elixir e o Phoenix instalados, siga essa [documentação](https://hexdocs.pm/phoenix/installation.html#content)

  Ambiente configurado, siga os passos:

  1. Instalar as dependências: `mix deps.get`
  2. Instalar as dependências do Node: `npm install` dentro do diretório `assets`
  3. Iniciar o servidor: `mix phx.server`

Agora visite [`localhost:4000`](http://localhost:4000) no seu navegador.
