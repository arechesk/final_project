FROM ruby:3.2.2

# установка библиотек для работы приложения (сейчас отсутствуют)
RUN apt-get update -qq && apt-get install -y locales
RUN apt-get install -y vim zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/arechesk/ohmyzsh/master/tools/install.sh)"

# установка локали, чтобы испльзовать русский в консоли внутри контейнера
RUN echo "ru_RU.UTF-8 UTF-8" > /etc/locale.gen && \
  locale-gen ru_RU.UTF-8 && \
  /usr/sbin/update-locale LANG=ru_RU.UTF-8
ENV LC_ALL ru_RU.UTF-8

ENV APP_PATH=/usr/src
WORKDIR $APP_PATH



# устаналиваем гемы, необходимые приложению
COPY Gemfile* $APP_PATH/
RUN bundle install

# копируем код приложения
COPY . .

# сообщаем другим разработчикам и devopsам о том, на каком порту работает наше приложение
EXPOSE 3001
RUN rails db:create
RUN rails db:migrate
COPY . .
# устанавливаем команду по умолчанию
CMD ["rails", "server", "-b", "0.0.0.0"]
