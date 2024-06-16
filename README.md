### WSL2 Ubuntu:

#### Новая группа для текущего пользователя:

Для совместной работы с файлами из IDE и веб-серверу/генераторам файлов Ruby из Docker, добавьте группу пользователей:
```bash
sudo groupadd -g 830 site_editor
```
`GID` `830` указан также в `.env` (из `.env.default` надо создать копию `.env`) переменной `SITE_EDITOR_GID`

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