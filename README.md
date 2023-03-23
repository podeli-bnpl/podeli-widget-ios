# PodeliWidget

## Установка

Для установки необходимо к основному таргету приложения добавить Pod:
```ruby
pod 'PodeliWidget', :git => 'https://github.com/podeli-bnpl/podeli-widget-ios.git', :tag => '0.0.13'
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
Вызов функции по нажатию на "Подробные условия"
Добавить протокол в родительский класс.

Пример:
```swift
ViewController: UIViewController, PodeliWidgetDelegate
```
Установить делегат
```swift
widgetView.delegate = self
```
Вызывать функцию в родительском классе
```swift
    func showInfoService() {
        //Call to service info
    } 
```


## Пример
Пример находится в проекте, в таргете DemoWidget

## Команда разработки

Николай Малофеев, n.malofeev@podeli.ru


