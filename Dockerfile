FROM httpd:2.4
# Данный образ базируется на стандартном образе Debian+Apache 2.4: https://store.docker.com/images/httpd

MAINTAINER Petr Myazin <petr.myazin@gmail.com>

# Копируем дистрибутив в директорию dist
COPY deb64.tar.gz /dist/deb64.tar.gz

# Разархивируем дистрибутив
RUN tar -xzf /dist/deb64.tar.gz -C /dist \
  # и устанавливаем пакеты 1С в систему внутри контейнера
  && dpkg -i /dist/*.deb \
  # и тут же удаляем исходные deb файлы дистрибутива, которые нам уже не нужны
  && rm /dist/*.deb

# Копируем внутрь контейнера заранее подготовленный конфиг от Apache
COPY httpd.conf /usr/local/apache2/conf/httpd.conf

# Копируем внутрь контейнера заранее подготовленный конфиг с настройками подключения к серверу 1С
COPY default.vrd /usr/local/apache2/htdocs/BuhBase/default.vrd
