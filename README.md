# KKOApp

Это приложение разработано в рамках обучения языку программирования **Swift**.
  
**KKOApp** представляет собой приложение для кофейни, предоставляющее возможность: узнать о проводимых акциях и новостях кофейни, ознакомления с ассортиментом кофейни, заказ понравившейся позиции, использования купонов, доступа к профилю аккаунта, где есть возможность: *узнать ближайшее местоположение кофейни на карте и проложить к ней маршрут, привязать карту для онлайн оплаты, узнать статус приготовления заказанной позиции, персонализировать иконку приложения и внешний вид профиля, узнать текущие сведения о погоде для помощи в выборе кофе, возможность активации защиты Face ID/ Touch ID для защиты персональных данных.*

## Подготовка

Ниже представлена пошаговая инструкция подготовки и запуска приложения на симмуляторе или телефоне.

### Потребуется

Перечень оборудования и программ

```
- Устройство с MacOS
- Xcode
- iPhone с версией 15.5 и выше или запуск в симмуляторе на устройстве MacOS
```

### Установка

Инструкция по установке

```
1. Скачать zip файл или командой git clone получить копию ветки main на свой ПК
2. Открыть терминал в папке или с помощью команды cd *перетащить папку с программой* в терминале снавигироваться на папку с проектом
3. Ввести команду pod install
4. После успешной установки Pod файлов запустить файл KKOApp.xcworkspace
5. Запустить программу на симмуляторе или iPhone
```

## Скриншоты
Ниже представлены скриншоты графического интерфейса приложения

<p align="center">
  <img src="https://github.com/nek-to/KKOApp/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2012%20Pro%20-%202022-09-11%20at%2016.36.34.png" width="200" >
  <img src="https://github.com/nek-to/KKOApp/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2012%20Pro%20-%202022-09-11%20at%2016.36.39.png" width="200" >
  <img src="https://github.com/nek-to/KKOApp/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2012%20Pro%20-%202022-09-11%20at%2016.37.19.png" width="200" >
  <img src="https://github.com/nek-to/KKOApp/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2012%20Pro%20-%202022-09-11%20at%2016.37.28.png" width="200" >
  <img src="https://github.com/nek-to/KKOApp/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2012%20Pro%20-%202022-09-11%20at%2016.37.42.png" width="200" >
  <img src="https://github.com/nek-to/KKOApp/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2012%20Pro%20-%202022-09-11%20at%2016.37.48.png" width="200" >
  <img src="https://github.com/nek-to/KKOApp/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2012%20Pro%20-%202022-09-11%20at%2016.38.15.png" width="200" >
  <img src="https://github.com/nek-to/KKOApp/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2012%20Pro%20-%202022-09-11%20at%2016.40.23.png" width="200" >
</p>


## Используемые технологии

* UIKit - Использование UI элементов
* Сocoa Touch Class - Библиотека абстрактных представлений
* GitHub - Контроль версий
* [WeatherBit](https://www.weatherbit.io/api) - Open api погоды
* [Upslash](https://unsplash.com/developers) - Open api стоковых картинок и фотографий
* [Lottie-iOS](https://github.com/airbnb/lottie-ios) - Воспроизведение JSON анимаций
* [Realm](https://github.com/realm/realm-swift) - Локальное хранилище данных
* [Firebase](https://firebase.google.com/docs/auth/ios/start) - Аутентификация аккаунтов
* [SwiftLint](https://github.com/realm/SwiftLint)  - Инструмент для соблюдения стиля и соглашений Swift 

## Автор

* **Nik Gribok** - [Nek-to](https://github.com/nek-to) - автор дизайна и кода
