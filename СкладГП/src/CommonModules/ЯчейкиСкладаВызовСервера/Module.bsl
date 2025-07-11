Функция ПолучитьОстаткиЯчейки(Ячейка) Экспорт
	Если ОбщегоНазначенияВызовСервераПовтИсп.БазаПУ().ЭтоERP Тогда
		ТекстЗапроса = 
		"ВЫБРАТЬ
		|	УНИКАЛЬНЫЙИДЕНТИФИКАТОР(РаспределениеПоЯчейкам.Ячейка) КАК Ячейка,
		|	РаспределениеПоЯчейкам.Ряд КАК Ряд,
		|	РаспределениеПоЯчейкам.Уровень КАК Уровень,
		|	УНИКАЛЬНЫЙИДЕНТИФИКАТОР(РаспределениеПоЯчейкам.НомерПакета) КАК ПакетID,
		|	РаспределениеПоЯчейкам.НомерПакета.Код КАК НомерПакетаКод,
		|	РаспределениеПоЯчейкам.НомерПакета.ДатаВыпуска КАК НомерПакетаДатаВыпуска
		|ПОМЕСТИТЬ вт_остаткиЯчеек
		|ИЗ
		|	Справочник.Склады КАК Склады
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.VLP_ДвижениеПиломатериаловНаСкладахВрем.Остатки КАК ОстаткиПМ
		|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.vlp_РаспределениеПакетовПоЯчейкамСклада.СрезПоследних КАК РаспределениеПоЯчейкам
		|			ПО (ОстаткиПМ.НомерПакета = РаспределениеПоЯчейкам.НомерПакета)
		|		ПО (Склады.Ссылка = ОстаткиПМ.Склад)
		|ГДЕ
		|	Склады.ИмяПредопределенныхДанных = &ИмяПредопределенных
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	вт_остаткиЯчеек.Ячейка КАК Ячейка,
		|	вт_остаткиЯчеек.Ряд КАК Ряд,
		|	вт_остаткиЯчеек.Уровень КАК Уровень,
		|	вт_остаткиЯчеек.ПакетID КАК ПакетID,
		|	вт_остаткиЯчеек.НомерПакетаКод КАК НомерПакета,
		|	вт_остаткиЯчеек.НомерПакетаДатаВыпуска КАК ДатаВыпуска
		|ИЗ
		|	вт_остаткиЯчеек КАК вт_остаткиЯчеек
		|ГДЕ
		|	вт_остаткиЯчеек.Ячейка = &Ячейка";

	Иначе
		ТекстЗапроса = 
		"ВЫБРАТЬ
		|	УНИКАЛЬНЫЙИДЕНТИФИКАТОР(РаспределениеПоЯчейкам.Ячейка) КАК Ячейка,
		|	РаспределениеПоЯчейкам.Ряд КАК Ряд,
		|	РаспределениеПоЯчейкам.Уровень КАК Уровень,
		|	УНИКАЛЬНЫЙИДЕНТИФИКАТОР(РаспределениеПоЯчейкам.НомерПакета) КАК ПакетID,
		|	РаспределениеПоЯчейкам.НомерПакета.Код КАК НомерПакетаКод,
		|	РаспределениеПоЯчейкам.НомерПакета.ДатаВыпуска КАК НомерПакетаДатаВыпуска
		|ПОМЕСТИТЬ вт_остаткиЯчеек
		|ИЗ
		|	Справочник.Склады КАК Склады
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.VLP_ДвижениеПиломатериаловНаСкладахВрем.Остатки КАК ОстаткиПМ
		|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.vlp_РаспределениеПакетовПоЯчейкамСклада.СрезПоследних КАК РаспределениеПоЯчейкам
		|			ПО (ОстаткиПМ.НомерПакета = РаспределениеПоЯчейкам.НомерПакета)
		|		ПО (Склады.Ссылка = ОстаткиПМ.Склад)
		|ГДЕ
		|	Склады.ИмяПредопределенныхДанных В (&МассивСкладовПУ)
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	вт_остаткиЯчеек.Ячейка КАК Ячейка,
		|	вт_остаткиЯчеек.Ряд КАК Ряд,
		|	вт_остаткиЯчеек.Уровень КАК Уровень,
		|	вт_остаткиЯчеек.ПакетID КАК ПакетID,
		|	вт_остаткиЯчеек.НомерПакетаКод КАК НомерПакета,
		|	вт_остаткиЯчеек.НомерПакетаДатаВыпуска КАК ДатаВыпуска
		|ИЗ
		|	вт_остаткиЯчеек КАК вт_остаткиЯчеек
		|ГДЕ
		|	вт_остаткиЯчеек.Ячейка = &Ячейка";
	КонецЕсли;
	
	СтруктураЗапроса = УКО.НоваяСтруктураПроизвольногоЗапроса();
	СтруктураЗапроса.ТекстЗапроса = ТекстЗапроса;
	СтруктураЗапроса.ПараметрыЗапроса.Вставить("МассивСкладовПУ", ОбщегоНазначенияВызовСервераПовтИсп.МассивСкладовПУ());
	СтруктураЗапроса.ПараметрыЗапроса.Вставить("Ячейка", Ячейка.УникальныйИдентификатор());
	
	ДанныеПУ = УКО.ПолучитьДанныеПроизвольногоЗапроса(СтруктураЗапроса);
	Возврат ДанныеПУ;
КонецФункции

Функция ПолучитьОстаткиЯчейкиЛокально(Ячейка) Экспорт
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ОстаткиПакетовНаСкладах.НомерПакета КАК НомерПакета,
	|	ОстаткиПакетовНаСкладах.Объем КАК Объем,
	|	ОстаткиПакетовНаСкладах.Досок КАК Досок,
	|	ОстаткиПакетовНаСкладах.Ячейка КАК Ячейка,
	|	ОстаткиПакетовНаСкладах.Ряд КАК Ряд,
	|	ОстаткиПакетовНаСкладах.Уровень КАК Уровень
	|ПОМЕСТИТЬ вт_Остатки
	|ИЗ
	|	РегистрСведений.ОстаткиПакетовНаСкладах КАК ОстаткиПакетовНаСкладах
	|ГДЕ
	|	ОстаткиПакетовНаСкладах.Склад В (&Склады)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	СвойстваПакетов.Номер КАК НомерПакета,
	|	ВложенныйЗапрос.НомерПакета КАК ПакетID,
	|	СвойстваПакетов.ДатаВыпуска КАК ДатаВыпуска,
	|	ВложенныйЗапрос.Ячейка КАК Ячейка,
	|	ВложенныйЗапрос.Ряд КАК Ряд,
	|	ВложенныйЗапрос.Уровень КАК Уровень,
	|	ВложенныйЗапрос.Объем КАК Объем,
	|	ВложенныйЗапрос.Досок КАК Досок,
	|	СвойстваПакетов.Сечение КАК Сечение,
	|	СвойстваПакетов.СечениеТолщина КАК СечениеТолщина,
	|	СвойстваПакетов.СечениеШирина КАК СечениеШирина,
	|	СвойстваПакетов.ВидПродукции КАК ВидПродукции,
	|	СвойстваПакетов.Сорт КАК Сорт,
	|	СвойстваПакетов.ТипРаспила КАК ТипРаспила,
	|	СвойстваПакетов.ДлинаТ КАК ДлинаТ,
	|	СвойстваПакетов.Влажность КАК Влажность
	|ИЗ
	|	(ВЫБРАТЬ
	|		вт_Остатки.НомерПакета КАК НомерПакета,
	|		вт_Остатки.Объем КАК Объем,
	|		вт_Остатки.Досок КАК Досок,
	|		вт_Остатки.Ячейка КАК Ячейка,
	|		вт_Остатки.Ряд КАК Ряд,
	|		вт_Остатки.Уровень КАК Уровень
	|	ИЗ
	|		вт_Остатки КАК вт_Остатки
	|	ГДЕ
	|		вт_Остатки.Ячейка = &Ячейка) КАК ВложенныйЗапрос
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.СвойстваПакетов КАК СвойстваПакетов
	|		ПО ВложенныйЗапрос.НомерПакета = СвойстваПакетов.НомерПакета";
	
	Запрос.УстановитьПараметр("Склады",		ОбщегоНазначенияВызовСервераПовтИсп.МассивСкладов());
	Запрос.УстановитьПараметр("Ячейка", 	Ячейка);
	Возврат Запрос.Выполнить().Выгрузить();
КонецФункции

Функция ТекущийАдресПакета(Пакет) Экспорт
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ОстаткиПакетовНаСкладах.Ячейка КАК Ячейка,
	|	ОстаткиПакетовНаСкладах.Ряд КАК Ряд,
	|	ОстаткиПакетовНаСкладах.Уровень КАК Уровень
	|ИЗ
	|	РегистрСведений.ОстаткиПакетовНаСкладах КАК ОстаткиПакетовНаСкладах
	|ГДЕ
	|	ОстаткиПакетовНаСкладах.НомерПакета = &НомерПакета";
	Запрос.УстановитьПараметр("НомерПакета",Пакет);
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Возврат СтрШаблон("%1/%2/%3", Выборка.Ячейка, Выборка.Ряд, Выборка.Уровень);
	КонецЕсли;
	
КонецФункции

Процедура ДобавитьРядНаСервере(ВыбраннаяЯчейка, РядыЯчейки, ТекущийРяд, КоличествоУровнейЯчейки, Слева = ИСТИНА) Экспорт
	
	ЯчейкиСклада.ДобавитьРядНаСервере(ВыбраннаяЯчейка, РядыЯчейки, ТекущийРяд, КоличествоУровнейЯчейки, Слева)
	
КонецПроцедуры

Процедура РазместитьПакетВЯчейке(Знач Пакет, Знач Ячейка, Знач Ряд, Знач Уровень, ОбменДаннымиЗагрузка = ЛОЖЬ, ЕстьСвязь = ЛОЖЬ) Экспорт
	
	ЯчейкиСклада.РазместитьПакетВЯчейке(Пакет, Ячейка, Ряд, Уровень, ОбменДаннымиЗагрузка, ЕстьСвязь);

КонецПроцедуры

Процедура РазместитьМассивПакетовВЯчейке(МассивРазмещений) Экспорт
	
	ЯчейкиСклада.РазместитьМассивПакетовВЯчейке(МассивРазмещений);

КонецПроцедуры

Процедура ОбновитьПакетыЯчейкиНаСервере(мЯчейка, ЕстьСвязь) Экспорт
	
	Если ЕстьСвязь Тогда
		СлужебныйОбновление.ОбновитьОстаткиПакетовНаСкладе(мЯчейка);
	КонецЕсли;
	
КонецПроцедуры

Функция ПолучитьПакетыНаВилах() Экспорт
	Возврат ЯчейкиСклада.ПолучитьПакетыНаВилах();
КонецФункции

Процедура ДобавитьПакетНаВилы(id) Экспорт
	ЯчейкиСклада.ДобавитьПакетНаВилы(id);
КонецПроцедуры

Процедура УбратьПакетСВил(id) Экспорт
	ЯчейкиСклада.УбратьПакетСВил(id);
КонецПроцедуры

Функция НайтиНовыйШтабельДляПакета(Пакет, ИсключаяШтабеля = Неопределено) Экспорт
	
	МассивШтабелей = НайтиНовыеШтабеляДляПакета(Пакет, ИсключаяШтабеля, 1);
	
	Если МассивШтабелей.Количество() = 0 Тогда
		Возврат НЕОПРЕДЕЛЕНО
	Иначе
		Возврат МассивШтабелей[0];
	КонецЕсли;
	
КонецФункции

Функция НайтиНовыеШтабеляДляПакета(Пакет, ИсключаяШтабеля = Неопределено, КоличествоШтабелей = 5) Экспорт
	
	СвойстваПакета = Пакеты.СвойстваПакетаМоб(Пакет);
	Запрос = Пакеты.НовыйЗапросаПакетовСклада(ОбщегоНазначенияВызовСервераПовтИсп.МассивСкладов(), "Вт");
		
	Запрос.УстановитьПараметр("Сечение", СвойстваПакета.Сечение);
	Запрос.Текст = Запрос.Текст +"
	|		И СвойстваПакетов.Сечение в (&Сечение)";
	
	Запрос.УстановитьПараметр("Порода", СвойстваПакета.Порода);
	Запрос.Текст = Запрос.Текст +"
	|		И СвойстваПакетов.Порода в (&Порода)";
	
	Запрос.УстановитьПараметр("Сорт", СвойстваПакета.Сорт);
	Запрос.Текст = Запрос.Текст +"
	|		И СвойстваПакетов.Сорт в (&Сорт)";  
	
	Запрос.УстановитьПараметр("Влажность", СвойстваПакета.Влажность);
	Запрос.Текст = Запрос.Текст +"
	|		И СвойстваПакетов.Влажность в (&Влажность)"; 
	
	Запрос.УстановитьПараметр("ИсключаяШтабеля", ИсключаяШтабеля);
	Запрос.Текст = Запрос.Текст +"
	|		И ЕСТЬNULL(ОстаткиПакетовНаСкладах.Ячейка, ЗНАЧЕНИЕ(Справочник.Ячейки.ПУстаяСсылка)) Не в (&ИсключаяШтабеля)";
	
	Запрос.Текст = Запрос.Текст +"
	|		И НЕ ЕСТЬNULL(ОстаткиПакетовНаСкладах.Ячейка, ЗНАЧЕНИЕ(Справочник.Ячейки.ПУстаяСсылка)) = ЗНАЧЕНИЕ(Справочник.Ячейки.ПУстаяСсылка)"; 
	
	Запрос.Текст = Запрос.Текст +"
	|		И НЕ ОстаткиПакетовНаСкладах.Ячейка.ЗапретПополнения
	|		И НЕ ОстаткиПакетовНаСкладах.Ячейка.ЭтоЯчейкаОТК";
	
	Запрос.Текст = Запрос.Текст +"
	|		И ЕСТЬNULL(ОстаткиПакетовНаСкладах.Ряд, 0) > 0";
	
	Запрос.Выполнить(); 

	Запрос.УстановитьПараметр("Партия", СвойстваПакета.Партия);
	Запрос.УстановитьПараметр("ВидПродукции", СвойстваПакета.ВидПродукции);
	Запрос.УстановитьПараметр("ДлинаТ", СвойстваПакета.ДлинаТ);
	Запрос.УстановитьПараметр("ИсключаяШтабеля", ИсключаяШтабеля);

	
	Запрос.Текст = 
	"ВЫБРАТЬ Первые "+КоличествоШтабелей+"
	|	Вт.Ячейка КАК Штабель,
	|	Вт.ДатаВыпуска КАК ДатаВыпуска,
	|	Вт.Партия = &Партия КАК ЭтаПартия,
	|	Вт.ВидПродукции = &ВидПродукции КАК ЭтотВидПродукции,
	|	Вт.ДлинаТ = &ДлинаТ КАК ЭтаДлина
	|ИЗ
	|	Вт КАК Вт
	|УПОРЯДОЧИТЬ ПО
	|	ЭтаПартия УБЫВ,
	|	ЭтотВидПродукции УБЫВ,
	|	ЭтаДлина УБЫВ,
	|	ДатаВыпуска УБЫВ";
	
	Результат = Запрос.Выполнить(); 
	МассивШтабелей = Новый Массив;
	Если НЕ Результат.Пустой() Тогда
		МассивШтабелей = Результат.Выгрузить().ВыгрузитьКолонку("Штабель");
	КонецЕсли;
	Возврат МассивШтабелей

КонецФункции

Функция ЭтоШтабельИмеющийРядыУровни(Штабель) Экспорт 
	Если Штабель.ВидШтабеля = Перечисления.vlp_ВидыШтабелейСклада.Подсборка Тогда
		Возврат ЛОЖЬ
	ИначеЕсли Штабель.ВидШтабеля = Перечисления.vlp_ВидыШтабелейСклада.СтолПогрузки Тогда
		Возврат ЛОЖЬ
	Иначе
		Возврат Истина
	КонецЕсли;
КонецФункции

Функция ПолучитьЯчейкуПоID(КлючИдентификатор) Экспорт
	Возврат Справочники.Ячейки.ПолучитьСсылку(КлючИдентификатор);
КонецФункции

Функция ПривестиДанныеКСериализуемомуВиду(стрДанных) Экспорт
	Возврат ЯчейкиСклада.ПривестиДанныеКСериализуемомуВиду(стрДанных)
КонецФункции

Функция СвойстваЯчейки(Ячейка) ЭКспорт
	Если Не ЗначениеЗаполнено(Ячейка) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Запрос = Новый ЗАпрос;
	Запрос.УстановитьПараметр("Ячейка", Ячейка);
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Ячейки.Наименование КАК Наименование,
	|	Ячейки.НомерВСекторе КАК НомерВСекторе,
	|	Ячейки.ЗапретОтгрузки КАК ЗапретОтгрузки,
	|	Ячейки.ЗапретПополнения КАК ЗапретПополнения,
	|	Ячейки.Двухсторонний КАК Двухсторонний,
	|	Ячейки.ЭтоЯчейкаОТК КАК ЭтоЯчейкаОТК,
	|	Склады.Ссылка КАК Ссылка,
	|	Склады.ИмяПредопределенногоПУ КАК ИмяПредопределенногоПУ,
	|	УНИКАЛЬНЫЙИДЕНТИФИКАТОР(Склады.Ссылка) КАК Склад_Key,
	|	Склады.ВспомогательныйСклад КАК ВспомогательныйСклад,
	|	УНИКАЛЬНЫЙИДЕНТИФИКАТОР(Склады.ВспомогательныйСклад) КАК ВспомогательныйСклад1,
	|	Склады.ВспомогательныйСклад.ИмяПредопределенногоПУ КАК ВспомогательныйСкладИмяПредопределенногоПУ
	|ИЗ
	|	Справочник.Ячейки КАК Ячейки
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Склады КАК Склады
	|		ПО (ВЫБОР
	|				КОГДА Ячейки.Склад = ЗНАЧЕНИЕ(Справочник.Склады.ПустаяСсылка)
	|					ТОГДА Ячейки.Владелец = Склады.Ссылка
	|				ИНАЧЕ Ячейки.Склад = Склады.Ссылка
	|			КОНЕЦ)
	|ГДЕ
	|	Ячейки.Ссылка = &Ячейка";
	Возврат ОбщегоНазначения.СтрокаТаблицыЗначенийВСтруктуру(Запрос.Выполнить().Выгрузить()[0])
КонецФункции

Процедура ОбновитьОстаткиЯчеекИзОтветаПУ(Знач ДанныеОтвета, ЯчейкиОбработали) Экспорт
	Если ЯчейкиОбработали = Неопределено Тогда ЯчейкиОбработали = Новый Массив КонецЕсли;
	Если ТипЗнч(ДанныеОтвета) = Тип("Строка") Тогда
		ДанныеОтвета =  json.ПрочитатьДанныеJSONизСтроки_СериализаторXDTO(ДанныеОтвета);
	КонецЕсли;
	
	Для Каждого стр из ДанныеОтвета Цикл 
		Если Не ЗначениеЗаполнено(стр.НомерПакета) Тогда Продолжить КонецЕсли;
		Ячейка = Справочники.Ячейки.ПолучитьСсылку(стр.Ячейка);
		РазместитьПакетВЯчейке(стр.НомерПакета, Ячейка, стр.Ряд, стр.Уровень, ИСТИНА, ИСТИНА);
		Если ЯчейкиОбработали.Найти(Ячейка) = Неопределено Тогда ЯчейкиОбработали.Добавить(Ячейка) КонецЕСли;
	КонецЦикла;
	
КонецПроцедуры
