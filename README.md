Используется [phpenv](https://github.com/phpenv/phpenv)

### Настройка php

```bash
make copy-env
```
Указать версию php в `.env` - переменная `PHP_VERSION` (можно посмотреть версии здесь https://www.php.net/downloads.php)
Чтобы скопировать из контейнера конфиг, надо сделать в папке этого конфига докера (возьмем за условность
версию php `8.3.8`, но вы заместо этой версии поставьте свою, если будете менять):
```bash
docker-compose cp php:/home/docker_user/.phpenv/versions/8.3.8/etc/ ./php/8.3.8/
```
Конфиги php копируются в `./php/8.3.8/`
Файлы относящиеся к конфигу (`php.ini`, `php-fpm.conf`, `php-fpm.conf.default`, `conf.d/`, `php-fpm.d/`), 
остальные можно удалить

Суть в том, что все файлы выбранной версии php `./php/8.3.8/` копируются с заменой в папку контейнера 
`/home/docker_user/.phpenv/versions/8.3.8/etc/`
так, что для конкретной версии php вы можете настроить конфиг

Запустить build php-контейнера, файлы скопируются снова (докер понимает, что файлы изменены и копирует их снова,
а остальная часть повторного build'а проходит быстро, так как закеширована докером)
```bash
# Запустить build php-контейнера
make build-php
# Запустить build php-контейнера без кеша
make rebuild-php
```

Если нужно сложнее, настраивайте вручную, подключаясь к контейнеру

### WSL2 Ubuntu:

#### Новая группа для текущего пользователя:

```bash
make copy-env
```

Для совместной работы с файлами из IDE и веб-серверу/генераторам файлов из Docker, добавьте группу пользователей:
```bash
sudo groupadd -g 830 site_editor
```
`GID` `830` указан также в `.env` переменной `SITE_EDITOR_GID`

и добавить текущего пользователя в эту группу:
```bash
sudo usermod -a -G site_editor `whoami`
```

Проверить, что пользователь в группе:
```bash
groups `whoami`
```

#### Настройка git:

Для `git` в WSL2 Ubuntu написать:
https://stackoverflow.com/questions/71849415/i-cannot-add-the-parent-directory-to-safe-directory-in-git
```bash
git config --global --add safe.directory "*"
```
Чтобы из-за разрешенного внешнего доступа к файлам только по группе пользователей не писал ошибку при работе

#### Настройка терминала:
В `~/.bashrc` добавить:
```bash
echo "
umask 002
" >> ~/.bashrc
```

#### Настройка WSL:
В `/etc/wsl.conf` добавить (нужны root-права):
```bash
echo "
[filesystem]
umask=002
" | sudo tee -a /etc/wsl.conf
```

### Windows

#### PHPStorm:

Включить перевод на новую строку линуксовскую, чтобы линтер не выдавал ошибки из-за перевода строк
https://stackoverflow.com/a/40472391