# PodeliWidget

## Установка

Для установки необходимо к основному таргету приложения добавить Pod:
```ruby
pod 'PodeliWidget', :git => 'https://github.com/podeli-bnpl/podeli-widget-ios.git', :tag => '0.0.11'
```

## Использование

Для начала использования необходимо добавить import
```swift
import PodeliWidget

```
Загрузка шрифтов

Для того чтобы подгрузить шрифт
```swift
UIFont.loadFonts() - в AppDelegate, например
```
Далее настроить виджет 
```swift
let widget = PodeliWidgetView()
widget.configure() - по умолчанию устанавливаются проценты
widget.configure(with: 3000) - устанавливает определенную стоимость
```

## Пример
Пример находится в проекте, в таргете DemoWidget

## Команда разработки

Николай Малофеев, n.malofeev@podeli.ru


