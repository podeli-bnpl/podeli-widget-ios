# PodeliWidget

## Установка

Для установки необходимо к основному таргету приложения добавить Pod:
```ruby
pod 'PodeliWidget', :git => 'https://github.com/podeli-bnpl/podeli-widget-ios.git', :tag => '0.0.2''
```

## Использование

Для начала использования необходимо добавить import
```swift
import PodeliWidget

```
Далее настроить виджет 
```swift
let widget = PodeliWidgetView()
widget.configureWith(price: 3000)
```

## Пример
Пример находится в проекте, в таргете DemoWidget

## Команда разработки

Николай Малофеев, n.malofeev@podeli.ru


