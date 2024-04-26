# final_project
Команда проекта:
1. **Чавдарь Валерия Геннадьевна**
2. **Кузенкова Анна Павловна**
3. **Куликов Александр Павлович**

### Инструкция по запуску
```bash
git clone git@git-intern.digitalleague.ru:unnotigkeit/final_project.git
cd ./final_project
docker-compose build
docker-compose up
# Для создания и заполнения базы
docker-compose run app-tickets bash
rails db:create
rails db:migrate
rails db:seed
```
**В сервисе transaction есть swagger. Доступен по адресу localhost:3001/swagger**

## API

|Компонент|**Метод**|**Пример запроса**|**Пример ответа**|**Источник запроса**|
|--|--|--|--|--|
|Router|index|GET /tickets|[{id: 1, price:....}, {},...]|User|
|Router|block|PATCH /tickets/:id/block params(status: blocked)|{result: true, mesage: “ successfully blocked”}|User(Admin)|
|Router|show|GET tickets/:id|{id: 1, price:....}|User|
|Router|create|POST /bookings params(category: vip, date:11.07.24.)|{result: true, mesage: “ successfully booked”, booking_id: id}|User|
|Router|destroy|DELETE /bookings/:id|{result: true, mesage: “ successfully deleted”}|User|
|Router|create|POST /purchases params(booking_id, doc_type...)|{result: true, mesage: “purchase successful”, ticket_id: id}|User|
|Router|cost|GET /tickets/cost? date=13294&category=vip|{cost: 2400}|User|

|Компонент|**Метод**|**Пример запроса**|**Пример ответа**|**Источник запроса**|
|--|--|--|--|--|
|tickets|index|GET /tickets|[{id: 1, price:....}, {},...]|Router|
|tickets|update|PATCH /tickets/:id/block params(status: blocked)|{result: true, mesage: “ successfully blocked”}|Router|
|tickets|update|PATCH /tickets/:id/book params(status: booked)|{result: true, mesage: “ successfully booked”}|Bookings/ Purchases|
|tickets|update|PATCH /tickets/:id/unbook params(status: active)|{result: true, mesage: “ successfully unbooked”}|Bookings/ Purchases|
|tickets|show|GET tickets/:id|{id: 1, price:....}|Router|
|tickets|update|PATCH /tickets/:id/purchase params(status: purchased)|{result: true, mesage: “ successfully purchased”}|Bookings/ Purchases|
|tickets|recalculate_price|GET /tickets/recalculate params(type: vip)|{result: true, mesage: “ prices recalculated”}|Bookings/ Purchases|

|Компонент|**Метод**|**Пример запроса**|**Пример ответа**|**Источник запроса**|
|--|--|--|--|--|
|Bookings/ Purchases|create|POST /bookings params(category: vip, date:11.07.24.)|{result: true, mesage: “ successfully booked”, booking_id: id}| Router|
|Bookings/ Purchases|destroy|DELETE /bookings/:id|{result: true, mesage: “ successfully deleted”}|Router|
|Bookings/ Purchases|create|POST /purchases params(booking_id, doc_type...)|{result: true, mesage: “purchase successful”, ticket_id: id}|Router|


