#Область ПрограммныйИнтерфейс
// Получить идентификатор пакета по строке.
// 
// Параметры:
//  КодПакета - Строка - Код пакета
// 
// Возвращаемое значение:
//  УникальныйИдентификатор - УникальныйИдентификатор - Получить идентификатор пакета по строке
Функция ПолучитьИдентификаторПакетаПоСтроке(КодПакета) ЭКспорт
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	СвойстваПакетов.НомерПакета КАК НомерПакета
	|ИЗ
	|	Константа.АдресПУ КАК АдресПУ
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.СвойстваПакетов КАК СвойстваПакетов
	|		ПО АдресПУ.Значение = СвойстваПакетов.БазаПУ
	|ГДЕ
	|	СвойстваПакетов.Номер = &КодПакета";
	Запрос.УстановитьПараметр("КодПакета", КодПакета);
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат НЕОПРЕДЕЛЕНО
	Иначе
		Выборка = Результат.Выбрать();
		Выборка.Следующий();
		Возврат Выборка.НомерПакета;
	КонецЕсли;
КонецФункции

#КонецОбласти

Функция СвойстваПакетаМоб(Пакет) Экспорт 
	Запрос = НовыйЗапросаПакетовСклада(ОбщегоНазначенияВызовСервераПовтИсп.МассивСкладов());

	Если ТипЗнч(Пакет) = Тип("УникальныйИдентификатор") Тогда
		Запрос.Текст = Запрос.Текст +"
		|	И СвойстваПакетов.НомерПакета = &Пакет";
	Иначе
		Запрос.Текст = Запрос.Текст +"
		|	И СвойстваПакетов.Номер = &Пакет";
	КонецЕсли;
	Запрос.УстановитьПараметр("Пакет", Пакет);
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат Неопределено
	Иначе
		Ответ = ОбщегоНазначения.СтрокаТаблицыЗначенийВСтруктуру(Результат.Выгрузить()[0]);
		Ответ.Адрес = СтрШаблон("%1/%2/%3", СокрЛП(Ответ.Ячейка), Ответ.Ряд, Ответ.Уровень);
		Возврат Ответ;
	КонецЕсли;
	
КонецФункции 

Функция СвойстваМассиваПакетовМоб(МассивПакетов, ТипЭлементаМассива) Экспорт
	Запрос = НовыйЗапросаПакетовСклада(ОбщегоНазначенияВызовСервераПовтИсп.МассивСкладов());
	Если ТипЭлементаМассива = Тип("УникальныйИдентификатор") Тогда
		Запрос.Текст = Запрос.Текст +"
		|	И СвойстваПакетов.НомерПакета в (&МассивПакетов)";
	Иначе
		Запрос.Текст = Запрос.Текст +"
		|	И СвойстваПакетов.Номер в (&МассивПакетов)";
	КонецЕсли;
	Запрос.УстановитьПараметр("МассивПакетов", МассивПакетов);
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат Неопределено
	Иначе
		ТаблицаСвойств = Результат.Выгрузить();
		Если ТипЭлементаМассива = Тип("УникальныйИдентификатор") Тогда
			ТаблицаСвойств.Индексы.Добавить("НомерПакета");
		Иначе
			ТаблицаСвойств.Индексы.Добавить("Номер");
		КонецЕсли;
		
		Ответ = Новый Соответствие;
		Для Каждого м из МассивПакетов Цикл
			Если ТипЭлементаМассива = Тип("УникальныйИдентификатор") Тогда
				СтрокиСвойств = ТаблицаСвойств.НайтиСтроки(Новый Структура("НомерПакета", м));
			Иначе
				СтрокиСвойств = ТаблицаСвойств.НайтиСтроки(Новый Структура("Номер", м));
			КонецЕсли;
			СвойстваПакета = Неопределено;
			Если СтрокиСвойств.Количество() > 0 Тогда
				СвойстваПакета = СтрокиСвойств[0]
			КонецЕсли;
			Ответ.Вставить(м, СвойстваПакета)
		КонецЦикла;

		Возврат Ответ;
	КонецЕсли;
	
КонецФункции

Процедура ЗаписатьСвойстваПакета(стр) Экспорт
	МенеджерСвойств = РегистрыСведений.СвойстваПакетов;
	
	НовСвойство = МенеджерСвойств.СоздатьМенеджерЗаписи();
	НовСвойство.БазаПУ			 = ОбщегоНазначенияВызовСервераПовтИсп.БазаПУ();
	НовСвойство.НомерПакета		 = стр.НомерПакета;
	НовСвойство.Сечение			 = СтрШаблон("%1х%2", стр.Толщина, стр.Ширина);
	НовСвойство.СечениеТолщина	 = стр.Толщина;
	НовСвойство.СечениеШирина	 = стр.Ширина;
	НовСвойство.ВидПродукции	 = Справочники.ВидыПродукции.ПолучитьСсылку(стр.ВидПродукции);
	НовСвойство.Сорт			 = Справочники.Сорта.ПолучитьСсылку(стр.Сорт);
	НовСвойство.ТипРаспила		 = Справочники.ТипыРаспила.ПолучитьСсылку(стр.ТипРаспила);
	НовСвойство.Влажность		 = Справочники.Влажности.ПолучитьСсылку(стр.Влажность);
	Если стр.ДлинаОт = стр.ДлинаДо Тогда
		НовСвойство.ДлинаТ			 = СтрШаблон("%1м", стр.ДлинаДо);
	Иначе
		НовСвойство.ДлинаТ			 = СтрШаблон("%1-%2м", стр.ДлинаОт, стр.ДлинаДо);
	КонецЕсли;
	НовСвойство.ДлинаОт			 = стр.ДлинаОт;
	НовСвойство.ДлинаДо			 = стр.ДлинаДо;
	НовСвойство.Номер			 = стр.НомерПакетаКод;
	НовСвойство.ДатаВыпуска		 = стр.НомерПакетаДатаВыпуска;
	НовСвойство.Порода			 = стр.Порода;
	НовСвойство.Состояние		 = стр.Состояние;
	
	НовСвойство.Объем			 = стр.Объем;
	НовСвойство.Досок			 = стр.Досок;
	
	НовСвойство.Партия			 = стр.Партия;
	
	Попытка
		НовСвойство.Записать();
	Исключение
	КонецПопытки;
	
КонецПроцедуры

Процедура ЗаписатьОстаткиПакета(стр, ЭтоЗагрузка = ИСТИНА) Экспорт
	
	Если ЗначениеЗаполнено(стр.Ячейка) Тогда
		Ячейка = Справочники.Ячейки.ПолучитьСсылку(стр.Ячейка);
	Иначе
		Ячейка = Справочники.Ячейки.ПустаяСсылка()
	КонецЕсли;

	Склад = Ячейка.Склад;
	Если не ЗначениеЗаполнено(Склад) Тогда
		Склад = ОбщегоНазначенияВызовСервераПовтИсп.СкладПоИдентификатору(стр.Склад);
	КонецЕсли;
	
	НЗ = РегистрыСведений.ОстаткиПакетовНаСкладах.СоздатьНаборЗаписей();
	НЗ.Отбор.Склад.Установить(Склад);
	НЗ.Отбор.НомерПакета.Установить(стр.НомерПакета);
	НЗ.ОбменДанными.Загрузка = ЭтоЗагрузка;
	Если НЗ.ОбменДанными.Загрузка Тогда 
		НЗ.ДополнительныеСвойства.Вставить("ИзмененияНеВыгружатьСразу", ЭтоЗагрузка);
		НЗ.ОбменДанными.Получатели.АвтоЗаполнение = ЛОЖЬ;
		НЗ.ОбменДанными.Получатели.Очистить();
	КонецЕсли;
	
	Нов = НЗ.Добавить();
	Нов.Склад = Склад;
	Нов.НомерПакета = стр.НомерПакета;
	Нов.Объем = стр.Объем;
	Нов.Досок = стр.Досок; 
	Нов.Ячейка = Ячейка;

	Нов.Ряд = стр.Ряд;
	Нов.Уровень = стр.Уровень;
	Нов.Номер = стр.НомерПакетаКод;
	
	НЗ.Записать(ИСТИНА);
	
КонецПроцедуры

Процедура ЗаписатьОстаткиСвойстваПакетовНЗ(ДанныеПУ) Экспорт
	Если ТипЗнч(ДанныеПУ) = Тип("Массив") Тогда
		Возврат
	КонецЕсли;
	
	Вт_Склады = ДанныеПУ.Скопировать(,"Склад");
	Вт_Склады.Свернуть("Склад");
	мСклады = Вт_Склады.ВыгрузитьКолонку("Склад");
	БазаПУ = ОбщегоНазначенияВызовСервераПовтИсп.БазаПУ();
	Для Каждого ОписаниеСклада из мСклады Цикл
		Склад = ОбщегоНазначенияВызовСервераПовтИсп.СкладПоИдентификатору(Строка(ОписаниеСклада));
		
		НЗ_Остатки = РегистрыСведений.ОстаткиПакетовНаСкладах.СоздатьНаборЗаписей();
		НЗ_Остатки.ОбменДанными.Загрузка = ИСТИНА;
		Если НЗ_Остатки.ОбменДанными.Загрузка Тогда
			НЗ_Остатки.ОбменДанными.Получатели.АвтоЗаполнение = ЛОЖЬ;
		КонецЕсли;
		
		НЗ_Остатки.Отбор.Склад.Установить(Склад);
		НЗ_Остатки.Прочитать();
		вт_Остатки = НЗ_Остатки.Выгрузить();
		вт_Остатки.Индексы.Добавить("НомерПакета");	
		
		НЗ_Свойства = РегистрыСведений.СвойстваПакетов.СоздатьНаборЗаписей();
		НЗ_Свойства.ОбменДанными.Загрузка = ИСТИНА;
		Если НЗ_Свойства.ОбменДанными.Загрузка Тогда
			НЗ_Свойства.ОбменДанными.Получатели.АвтоЗаполнение = ЛОЖЬ;
		КонецЕсли;
		НЗ_Свойства.Отбор.БазаПУ.Установить(БазаПУ);
		НЗ_Свойства.Прочитать(); 
		вт_Свойства = НЗ_Свойства.Выгрузить();
		вт_Свойства.Индексы.Добавить("НомерПакета");	
		
		ДанныеПУ_Склада = ДанныеПУ.Скопировать(Новый Структура("Склад", ОписаниеСклада));
		Для Каждого стр из ДанныеПУ_Склада Цикл
			//Остатки
			СтрокиПакета = вт_Остатки.НайтиСтроки(Новый Структура("НомерПакета", стр.НомерПакета));
			Если СтрокиПакета.Количество() = 0 Тогда
				Стр_Остатки = вт_Остатки.Добавить();
			Иначе
				Стр_Остатки = СтрокиПакета[0];
			КонецЕсли;
			Стр_Остатки.Склад = Склад;
			Стр_Остатки.НомерПакета = стр.НомерПакета;
			Стр_Остатки.Объем = стр.Объем;
			Стр_Остатки.Досок = стр.Досок;
			Если ЗначениеЗаполнено(стр.Ячейка) Тогда
				Стр_Остатки.Ячейка = Справочники.Ячейки.ПолучитьСсылку(стр.Ячейка);
			Иначе
				Стр_Остатки.Ячейка = Справочники.Ячейки.ПустаяСсылка()
			КонецЕсли;
			Стр_Остатки.Ряд = стр.Ряд;
			Стр_Остатки.Уровень = стр.Уровень;
			Стр_Остатки.Номер = стр.НомерПакетаКод;
			
			//Свойства
			СтрокиПакета = вт_Свойства.НайтиСтроки(Новый Структура("НомерПакета", стр.НомерПакета));
			Если СтрокиПакета.Количество() = 0 Тогда
				Стр_Свойства = вт_Свойства.Добавить();
			Иначе
				Стр_Свойства = СтрокиПакета[0];
			КонецЕсли;
			Стр_Свойства.БазаПУ			 = БазаПУ;
			Стр_Свойства.НомерПакета	 = стр.НомерПакета;
			Стр_Свойства.Сечение		 = СтрШаблон("%1х%2", стр.Толщина, стр.Ширина);
			Стр_Свойства.СечениеТолщина	 = стр.Толщина;
			Стр_Свойства.СечениеШирина	 = стр.Ширина;
			Стр_Свойства.ВидПродукции	 = Справочники.ВидыПродукции.ПолучитьСсылку(стр.ВидПродукции);
			Стр_Свойства.Сорт			 = Справочники.Сорта.ПолучитьСсылку(стр.Сорт);
			Стр_Свойства.ТипРаспила		 = Справочники.ТипыРаспила.ПолучитьСсылку(стр.ТипРаспила);
			Стр_Свойства.Влажность		 = Справочники.Влажности.ПолучитьСсылку(стр.Влажность);
			Если стр.ДлинаОт = стр.ДлинаДо Тогда
				Стр_Свойства.ДлинаТ		 = СтрШаблон("%1м", стр.ДлинаДо);
			Иначе
				Стр_Свойства.ДлинаТ		 = СтрШаблон("%1-%2м", стр.ДлинаОт, стр.ДлинаДо);
			КонецЕсли;
			Стр_Свойства.ДлинаОт		 = стр.ДлинаОт;
			Стр_Свойства.ДлинаДо		 = стр.ДлинаДо;
			Стр_Свойства.Номер			 = стр.НомерПакетаКод;
			Стр_Свойства.ДатаВыпуска	 = стр.НомерПакетаДатаВыпуска;
			Стр_Свойства.Порода			 = стр.Порода;
			Стр_Свойства.Состояние		 = стр.Состояние;
			
			Стр_Свойства.Объем			 = стр.Объем;
			Стр_Свойства.Досок			 = стр.Досок;
			
			Стр_Свойства.Партия			 = стр.Партия; 
			Если ДанныеПУ.Колонки.Найти("ПрефиксПроизводителя") = НЕОПРЕДЕЛЕНО Тогда
				Стр_Свойства.ПрефиксПроизводителя = "";
			Иначе
				Стр_Свойства.ПрефиксПроизводителя = стр.ПрефиксПроизводителя	
			КонецЕсли
			
		КонецЦикла;
		НЗ_Остатки.Загрузить(вт_Остатки);
		НЗ_Свойства.Загрузить(вт_Свойства);
		
		НЗ_Остатки.Записать(ИСТИНА);
		НЗ_Свойства.Записать(ИСТИНА);
		
	КонецЦикла;
	
КонецПроцедуры

Функция ОписаниеПакетаПоШаблону(Пакет, СвойстваПакета = Неопределено) Экспорт
	Если СвойстваПакета = Неопределено Тогда
		СвойстваПакета = СвойстваПакетаМоб(Пакет);	
	КонецЕсли;
	ДанныеШаблона = ОбщегоНазначенияВызовСервераПовтИсп.ШаблонПредставленияПакета();
	Если ДанныеШаблона.Текст = "" Тогда
		Возврат "";
	Иначе
		СтрПараметров = "СвойстваПакета."+СтрСоединить(ДанныеШаблона.Параметры, ", СвойстваПакета.");
		//@skip-check server-execution-safe-mode
		Возврат  Вычислить("СтрШаблон(ДанныеШаблона.Текст,"+СтрПараметров+")");
	КонецЕсли;	
КонецФункции

Функция НовыйЗапросаПакетовСклада(Склады, ИмяВремТаблицы = "") Экспорт
	Запрос = Новый Запрос;

	Запрос.УстановитьПараметр("Склады", Склады);
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	СвойстваПакетов.Сечение КАК Сечение,
	|	СвойстваПакетов.СечениеТолщина КАК СечениеТолщина,
	|	СвойстваПакетов.СечениеШирина КАК СечениеШирина,
	|	СвойстваПакетов.ВидПродукции КАК ВидПродукции,
	|	СвойстваПакетов.Сорт КАК Сорт,
	|	СвойстваПакетов.ТипРаспила КАК ТипРаспила,
	|	СвойстваПакетов.ДлинаТ КАК ДлинаТ,
	|	СвойстваПакетов.ДлинаОт КАК ДлинаОт,
	|	СвойстваПакетов.ДлинаДо КАК ДлинаДо,
	|	СвойстваПакетов.Влажность КАК Влажность,
	|	СвойстваПакетов.ДатаВыпуска КАК ДатаВыпуска,
	|	СвойстваПакетов.Номер КАК Номер,
	|	СвойстваПакетов.Порода КАК Порода,
	|	СвойстваПакетов.Состояние КАК Состояние,
	|	ЕСТЬNULL(ОстаткиПакетовНаСкладах.Объем, 0) КАК Объем,
	|	ЕСТЬNULL(ОстаткиПакетовНаСкладах.Досок, 0) КАК Досок,
	|	ЕСТЬNULL(ОстаткиПакетовНаСкладах.Ячейка, ЗНАЧЕНИЕ(Справочник.Ячейки.ПустаяСсылка)) КАК Ячейка,
	|	ЕСТЬNULL(ОстаткиПакетовНаСкладах.Ряд, 0) КАК Ряд,
	|	ЕСТЬNULL(ОстаткиПакетовНаСкладах.Уровень, 0) КАК Уровень,
	|	СвойстваПакетов.НомерПакета КАК НомерПакета,
	|	"""" КАК Адрес,
	|	НазначенныеПодсборки.Место КАК Подсборка,
	|	СвойстваПакетов.Партия КАК Партия
	|//Поместить вт
	|ИЗ
	|	РегистрСведений.СвойстваПакетов КАК СвойстваПакетов
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ОстаткиПакетовНаСкладах КАК ОстаткиПакетовНаСкладах
	|		ПО (ОстаткиПакетовНаСкладах.НомерПакета = СвойстваПакетов.НомерПакета)
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.НазначенныеПодсборки КАК НазначенныеПодсборки
	|		ПО СвойстваПакетов.НомерПакета = НазначенныеПодсборки.Пакет
	|ГДЕ
	|	ОстаткиПакетовНаСкладах.Склад в (&Склады)";
	Если Не ИмяВремТаблицы = "" Тогда
		Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "//Поместить вт", "Поместить "+ИмяВремТаблицы);	
	КонецЕсли;
	Возврат Запрос;
КонецФункции

