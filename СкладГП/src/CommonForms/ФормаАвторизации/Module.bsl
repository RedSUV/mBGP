Перем ОлдПУ;

&НаСервере
Процедура ПриСозданииНаСервере() Экспорт
	ВосстановимДанныеАвторизации();
КонецПроцедуры

&НаКлиенте
Процедура ПроверкиПередАвторизацией(Отказ)
	Если Не ЗначениеЗаполнено(АдресПУ) Тогда
		Отказ = ИСТИНА;	
	КонецЕсли;
	Если Не ЗначениеЗаполнено(Склад) Тогда
		Отказ = ИСТИНА;	
	КонецЕсли; 
	Если Не ЗначениеЗаполнено(Логин) Тогда
		Отказ = ИСТИНА;	
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Асинх Функция АвторизацияНаКлиенте()
	ОшибкиАвторизации = "";
	мАвторизацияВыполнена = ЛОЖЬ;
	
	Если ЕстьСвязь Тогда
		АвторизоватьсяНаСервере(мАвторизацияВыполнена, ОшибкиАвторизации);
	Иначе
		АвторизоватьсяАвтономно(мАвторизацияВыполнена, ОшибкиАвторизации);
	КонецЕсли;
	
	АвторизацияВыполнена = мАвторизацияВыполнена;
	
	Если АвторизацияВыполнена Тогда
		ЗапомнимДанныеАвторизации(); 
		Если ЕстьСвязь Тогда
			ЗапускФоновыхОбновленийПослеАвторизации(ЕстьСвязь);
			СлужебныйОбновлениеКлиент.ЗапуститьОбновлениеОстатковСклада(ЛОЖЬ);
		КонецЕсли;
		ИнтерфейсКлиент.НастройкаИнтерфейса();
		
		Оповестить("ВыполненаАвторизацияКлиента");
	Иначе
		ПоказатьПредупреждение(,ОшибкиАвторизации);
	КонецЕсли;
	Возврат АвторизацияВыполнена;
КонецФункции

&НаКлиенте
Асинх Процедура Авторизоваться(Команда)
	Перем ОшибкиАвторизации;
	
	Отказ = ЛОЖЬ;
	ПроверкиПередАвторизацией(Отказ);
	
	Если Отказ Тогда
		Сообщить("Авторизация невозможна");
		Возврат
	КонецЕсли;
	
	Элементы.ФормаАвторизоваться.Картинка = БиблиотекаКартинок.ДлительнаяОперация16;
	ОбновитьОтображениеДанных();

	АвторизацияВыполнена = Ждать АвторизацияНаКлиенте();
	
	Если АвторизацияВыполнена Тогда
		Состояние("Авторизация выполнена");
		Попытка
			Закрыть(АвторизацияВыполнена);
		Исключение 
			
		КонецПопытки
	Иначе
		Элементы.ФормаАвторизоваться.Картинка = Новый Картинка;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗапускФоновыхОбновленийПослеАвторизации(ЕстьСвязь)
	Если ЕстьСвязь Тогда
		Если Не Константы.ЭтоНеПервыйЗапуск.Получить() Тогда
			Константы.ПериодичностьВыгрузкиИзменений.Установить(60);
			Константы.ЭтоНеПервыйЗапуск.Установить(ИСТИНА);
		КонецЕсли;
		СлужебныйОбновление.ОбновитьСлужебныеСправочники(ИСТИНА);
		СлужебныйОбновление.ОтправитьАрхивТреков();
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ВосстановимДанныеАвторизации()
	АдресПУ = Константы.АдресПУ.Получить();
	Если Не ЗначениеЗаполнено(АдресПУ) Тогда
		АдресПУ = Справочники.БазыПУ.ЛДК;
	КонецЕсли;                          
	ОлдПУ = АдресПУ;
	
	Логин = Константы.ЛогинПУ.Получить();
	Пароль = Константы.ПарольПУ.Получить();
	Склад = Константы.Склад.Получить(); 
	АдресПУПриИзмененииНаСервере();
	ОбновитьПовторноИспользуемыеЗначения();
КонецПроцедуры

&НаСервере
Процедура ЗапомнимДанныеАвторизации()
	
	УстановитьПривилегированныйРежим(ИСТИНА);
	
	Константы.АдресПУ.Установить(АдресПУ);
	Константы.Склад.Установить(Склад);
	Константы.ЛогинПУ.Установить(Логин);
	Константы.ПарольПУ.Установить(Пароль);
	
	Константы.Authentication.Установить(ОбщегоНазначения.СформироватьAuthentication(Логин, Пароль));
	
	ОбновитьПовторноИспользуемыеЗначения();
КонецПроцедуры

&НаСервере
Процедура АвторизоватьсяНаСервере(мАвторизацияВыполнена = ЛОЖЬ, ОшибкиАвторизации)
	Перем НастройкиПУ;
	
	ДанныеАвторизации = Новый Структура("Путь,Логин,Пароль",
						АдресПУ,
						Логин,
						Пароль);
						
	Попытка						
		ДанныеПодписчика = Константы.ИдентификаторПодписчика.Получить();
		
		ДопЗаголовки = Новый Соответствие;
		ДопЗаголовки.Вставить("DeviceName", ПараметрыСеанса.ИдентификаторУстройства);
		ДопЗаголовки.Вставить("Login", Логин);
		ДопЗаголовки.Вставить("Accept-Encoding","zip");
		
		Ответ = http.post("/hs/ma_bgp/auth/",XMLСтрока(ДанныеПодписчика),,ДанныеАвторизации,, ДопЗаголовки);
		
		Если Ответ = Неопределено Тогда
			ОшибкиАвторизации = "Нет связи с сервером";	
		ИначеЕсли Ответ.КодСостояния = 200 Тогда
			Кодировка = http.ТипКодировки(Ответ);
			//в новой версии - настройки это свойство соответствия
			СтрокаТела = Ответ.ПолучитьТелоКакСтроку(Кодировка);
			ЗаголовкиОтвета = Ответ.Заголовки;
			ТипОтвета = ЗаголовкиОтвета.Получить("Accept-Encoding");
			Если ТипОтвета = НЕОПРЕДЕЛЕНО Тогда
				ТипОтвета = "json";	
			ИначеЕсли ТипОтвета = "zip" или ТипОтвета = "qzip" Тогда
				СтрокаТела = XMLЗначение(Тип("ХранилищеЗначения"), СтрокаТела).Получить()	
			КонецЕсли;
			
			ДанныеОтвета = json.ПрочитатьДанныеJSONизСтроки(СтрокаТела);
			Если НЕ  ДанныеОтвета = Неопределено Тогда
				Если ДанныеОтвета.Свойство("Настройки") Тогда
					НастройкиПУ = ДанныеОтвета.Настройки;
				Иначе
					НастройкиПУ = ДанныеОтвета;
				КонецЕсли;  
				мАвторизацияВыполнена = ИСТИНА;
			КонецЕсли;
			
			Если ДанныеОтвета.Свойство("Изменения") Тогда
				СлужебныйОбновление.ЗагрузитьИзмененияИзПУ(ДанныеОтвета.Изменения);
			КонецЕсли;
			
			УзелПУ = Ответ.Заголовки.Получить("Exchange_Node");
			Константы.УзелПУ.Установить(УзелПУ);

			ОшибкиАвторизации = "";	
			
			Константы.ФО_ДоступМастерБГП.Установить(НастройкиПУ.ДоступМастерБГП);
			Константы.ФО_ДоступПогрузчикБГП.Установить(НастройкиПУ.ДоступПогрузчикБГП);
			Константы.ФО_РаботаСЭлОчередью.Установить(НастройкиПУ.РаботаЭлОчередью);
			Константы.ФО_ДоступОстаткиСклада.Установить(НастройкиПУ.ДоступОстаткиСклада);
			Константы.ФО_ДоступРегистрацияПоврежденийПакетов.Установить(НастройкиПУ.ДоступРегистрацияПоврежденийПакетов);
			Если НастройкиПУ.Свойство("ИнвентаризацияПакетов") Тогда
				Константы.ФО_ИнвентаризацияПакетов.Установить(НастройкиПУ.ИнвентаризацияПакетов);	
			КонецЕсли;
			Если НастройкиПУ.Свойство("ПоказыватьВыходЦСП") Тогда
				Константы.ПоказыватьВыходЦСП.Установить(НастройкиПУ.ПоказыватьВыходЦСП);	
			КонецЕсли;

			Константы.ИмяНачальнойСтраницы.Установить(НастройкиПУ.ИмяНачальнойСтраницы);
			
			ОбновитьПовторноИспользуемыеЗначения();

		ИначеЕсли Ответ.КодСостояния = 401 Тогда
			ОшибкиАвторизации = "Неверный логин/пароль";
		ИначеЕсли Ответ.КодСостояния = 403 Тогда
			ОшибкиАвторизации = "У пользователя недостаточно прав";
		Иначе
			ОшибкиАвторизации = Ответ.ПолучитьТелоКакСтроку("windows-1251");
		КонецЕсли;
	Исключение
		ОшибкиАвторизации = "Нет связи с сервером("+ОписаниеОшибки()+")";
	КонецПопытки
КонецПроцедуры

&НаСервере
Процедура АвторизоватьсяАвтономно(АвторизацияВыполнена, ОшибкиАвторизации)
	Если Константы.Authentication.Получить() = ОбщегоНазначения.СформироватьAuthentication(Логин, Пароль) Тогда
		АвторизацияВыполнена = ИСТИНА;
	Иначе
		ОшибкиАвторизации = "Неверный логин/пароль"	
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	Если НЕ АвторизацияВыполнена Тогда
		ЗавершитьРаботуСистемы();
	Конецесли;
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьНастройки(Команда)
	СлужебныйОбновлениеВызовСервера.ЗаполнитьОбновитьПреопределенныйНастройки();
КонецПроцедуры

&НаКлиенте
Процедура АдресПУПриИзменении(Элемент)
	
	ОбновитьПовторноИспользуемыеЗначения();
	//АдресДляПингаПУ = МобильноеПриложениеСкладПУВызовСервера.ПолучитьАдресДляПинг(АдресПУ);
	АдресПУПриИзмененииНаСервере();
	НачатьПроверкуСвязиАсинх();

//	ПроверитьСвязь();
	
КонецПроцедуры

&НаСервере
Процедура АдресПУПриИзмененииНаСервере()
	Если ОлдПУ <> АдресПУ Тогда
		ТребуетсяОбновлениеНСИ = Истина;
	КонецЕсли;

	Если Склад.Владелец <> АдресПУ Тогда
		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	Склады.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.Склады КАК Склады
		|ГДЕ
		|	Склады.Владелец = &Владелец
		|	И НЕ Склады.ПометкаУдаления
		|	И Склады.ОтображатьПриАвторизации";
		Запрос.УстановитьПараметр("Владелец", АдресПУ);
		Выборка = Запрос.Выполнить().Выбрать();
		Если Выборка.Следующий() Тогда
			Склад = Выборка.Ссылка;	
		Иначе
			Склад = Справочники.Склады.ПустаяСсылка();
		КонецЕсли;
		
	КонецЕсли;
	ОбновитьПовторноИспользуемыеЗначения();
	ЗапомнимДанныеАвторизации()
КонецПроцедуры

&НаКлиенте
Процедура СкладПриИзменении(Элемент)
	ОбновитьПовторноИспользуемыеЗначения();
	ЗапомнимДанныеАвторизации();
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьДекорациюКачестваСвязи() Экспорт
	Если ЕстьСвязь Тогда
		Элементы.ДекорацияСтатусСвязи.Заголовок = Новый ФорматированнаяСтрока("соединение установлено",,WebЦвета.ТемноЗеленый);
	Иначе
		Элементы.ДекорацияСтатусСвязи.Заголовок = Новый ФорматированнаяСтрока("нет связи!",,WebЦвета.ТемноКрасный);
	КонецЕсли; 
КонецПроцедуры

&НаКлиенте
Асинх Процедура НачатьПроверкуСвязиАсинх()
	ИнтернетСоединениеКлиент.ПроверитьСвязь_Подключаемый(ИСТИНА);
КонецПроцедуры


&НаКлиенте
Процедура ПриОткрытии(Отказ) 
	НачатьПроверкуСвязиАсинх();
КонецПроцедуры

&НаКлиенте
Процедура ПриИзмененииПараметровЭкрана()
	ДанныеЭкрана = ПолучитьИнформациюЭкрановКлиента();
	ШиринаЭкрана = ДанныеЭкрана[0].Ширина;
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если ИмяСобытия = "ИзменениеКачестваСвязи"  Тогда
		ОбновитьДекорациюКачестваСвязи();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура АдресПУНачалоВыбора(Элемент, ДанныеВыбора, ВыборДобавлением, СтандартнаяОбработка)
	ОлдПУ = АдресПУ;
КонецПроцедуры
