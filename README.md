Container com jenkins para rodar em um cliente e, usando pipelines, executar comandos na máquina host e devolver o output para a tela.

Para gerar a imagem do docker:
docker build -t jenkins-container:v1 -f jenkins-container.Dockerfile .

Para salvar a imagem em um arquivo .tar:
docker save jenkins-container:v1 -o jenkins-container.tar

Para carregar a imagem do .tar:
docker load -i jenkins-container.tar

Para rodar manualmente:
docker run -p 8080:8080 --env-file=.env --name=jenkins -v [pasta_com_os_scripts]/pipes:/pipes jenkins-client:v1

Mas deve rodar com o script setup_jenkins.sh que já cria toda a estrutura e arquivos necessários para o funcionamento.

Isso roda usando os pipelines do linux, são arquivos que implementam o conceito de fila. Ao ler o que foi escrito, isso é limpo do arquivo.
O Jenkins envia o comando para o pipeline compartilhado no volume acima, a máquina host lê o comando, executa e grava o retorno no arquivo pipes/output.txt.
