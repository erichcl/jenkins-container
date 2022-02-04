#!/bin/bash

docker load -i jenkins-client.tar

pipe="pipes/jenkins.pipe"
output="pipes/output.txt"
CURRENT_FOLDER=`dirname "$0"`

# Garante que está no diretório correto
cd $CURRENT_FOLDER

mkdir -p pipes

# Cria os arquivos necessários
if [ ! -p "$PWD/$pipe" ]; then
    mkfifo $pipe
fi

if [ ! -f "$PWD/$output" ]; then
    touch $output
fi

# Cria o cron para garantir que o script necessário
# para o jenkins funcionar esteja funcionando mesmo com reboot
crontab -l > cron_bkp.txt
if ! grep -q "cron_job.sh" "cron_bkp.txt"; then
  echo "@reboot $PWD/cron_job.sh" >> cron_bkp.txt
fi
echo "$(cat cron_bkp.txt)"
crontab cron_bkp.txt
rm cron_bkp.txt

# Roda o script necessário para o jenkins funcionar
bash -c "exec -a ExecPipe ./execpipe.sh &"


# Cria o docker do jenkins já configurado
docker run -p 8080:8080 --env-file=.env --name=jenkins -v $PWD/pipes:/pipes jenkins-client:v1