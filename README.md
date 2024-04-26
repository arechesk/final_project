# final_project
# Группа №3
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

|Компонент|**Метод**|**Описание**|**Пример запроса**|**Пример ответа**|
|--|--|--|--|--|
|Router|index|Получить информацию обо всех доступных билетах|curl http://localhost:3000/tickets|[{id: 1, price:....}, {},...]|
|Router|check_availability|Проверить доступность билета на определенную дату:|curl http://localhost:3000/tickets/check_availability?date=09.07.2024&category=vip|{result: true, ticket_id: id cost: 1500}|
|Router|cost|Получить стоимость  билета на определенную дату:|curl http://localhost:3000/tickets/cost?date=09.07.2024&category=vip|{cost: 2400}|
|Router|create|Создать бронирование|curl -X POST -H "Content-Type: application/json" -d '{"booking":   {                      "date": "09.07.2024","category": "regular"  } }' http://localhost:3000/bookings|{result: true, mesage: “ successfully booked”, booking_id: id}|
|Router|create|Купить билет (по номеру полученной брони)|curl -X POST -H "Content-Type: application/json" -d '{"purchase": { "booking_id": "3834","first_name": "Obiwan","last_name": "Kennobi","doc_type": "passport","doc_number": "119647"}}' http://localhost:3000/purchases|{result: true, mesage: “ successfully deleted”}|


|Компонент|**Метод**|**Пример запроса**|**Пример ответа**|
|--|--|--|--|
|tickets|index|GET /tickets|[{id: 1, price:....}, {},...]|
|tickets|update|PATCH /tickets/:id/block params(status: blocked)|{result: true, mesage: “ successfully blocked”}|
|tickets|show|GET tickets/:id|{id: 1, price:....}|
|tickets|update|PATCH /tickets/:id/purchase params(status: purchased)|{result: true, mesage: “ successfully purchased”}|

|Компонент|**Метод**|**Описание**|**Пример запроса**|**Пример ответа**|
|--|--|--|--|--|
|Bookings/ Purchases|create|Создать бронирование|POST /bookings params(category: vip, date:11.07.24.)|{result: true, mesage: “ successfully booked”, booking_id: id}|
|Bookings/ Purchases|destroy|Удалить бронирование|DELETE /bookings/:id|{result: true, mesage: “ successfully deleted”}|
|Bookings/ Purchases|create|Оформить покупку|POST /purchases params(booking_id, doc_type...)|{result: true, mesage: “purchase successful”, ticket_id: id}|


