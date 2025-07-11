
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ПолучитьДанныеЗаявки()
КонецПроцедуры

&НаКлиенте
Асинх Процедура ПолучитьДанныеЗаявки()
	ЕстьСвязь = Ждать http_Клиент.ЕстьСвязь();
	Если Не ЕстьСвязь Тогда Возврат КонецЕсли;
	
	ИмяСобытияЖурнала = "ПолучениеДанныеТС";
	
	СтруктураЗапроса = УКО.НоваяСтруктураПроизвольногоЗапроса(); 
	Если ОбщегоНазначенияВызовСервераПовтИсп.ЭтоERP() Тогда
		СтруктураЗапроса.ТекстЗапроса = 
		"ВЫБРАТЬ
		|	УНИКАЛЬНЫЙИДЕНТИФИКАТОР(VLP_ЗаявкаНаПогрузку.Ссылка) КАК Заявка,
		|	VLP_ЗаявкаНаПогрузку.Номер КАК НомерЗаявки,
		|	VLP_ЗаявкаНаПогрузку.Водитель.Наименование КАК Водитель,
		|	VLP_ЗаявкаНаПогрузку.Соглашение.Наименование КАК Дополнение,
		|	VLP_ЗаявкаНаПогрузку.Контейнер.Наименование КАК Контейнер,
		|	VLP_ЗаявкаНаПогрузку.Транспорт.Наименование КАК НомерАвто,
		|	VLP_ЗаявкаНаПогрузку.Контрагент.Наименование КАК Покупатель
		|ИЗ
		|	Документ.pu_ЗаявкаНаПогрузку КАК VLP_ЗаявкаНаПогрузку
		|ГДЕ
		|	УНИКАЛЬНЫЙИДЕНТИФИКАТОР(VLP_ЗаявкаНаПогрузку.Ссылка) = &ЗаявкаНаПогрузку";	
	Иначе
		СтруктураЗапроса.ТекстЗапроса = 
		"ВЫБРАТЬ
		|	УНИКАЛЬНЫЙИДЕНТИФИКАТОР(VLP_ЗаявкаНаПогрузку.Ссылка) КАК Заявка,
		|	VLP_ЗаявкаНаПогрузку.Номер КАК НомерЗаявки,
		|	VLP_ЗаявкаНаПогрузку.Водитель.Наименование КАК Водитель,
		|	VLP_ЗаявкаНаПогрузку.ДопСоглашение.Наименование КАК Дополнение,
		|	VLP_ЗаявкаНаПогрузку.Контейнер КАК Контейнер,
		|	VLP_ЗаявкаНаПогрузку.НомерАвто КАК НомерАвто,
		|	VLP_ЗаявкаНаПогрузку.Покупатель.Наименование КАК Покупатель
		|ИЗ
		|	Документ.VLP_ЗаявкаНаПогрузку КАК VLP_ЗаявкаНаПогрузку
		|ГДЕ
		|	УНИКАЛЬНЫЙИДЕНТИФИКАТОР(VLP_ЗаявкаНаПогрузку.Ссылка) = &ЗаявкаНаПогрузку";
	КонецЕсли;
	СтруктураЗапроса.ПараметрыЗапроса.Вставить("ЗаявкаНаПогрузку", Заявка);

	ДанныеПУ = УКО.ПолучитьДанныеПроизвольногоЗапроса(СтруктураЗапроса,,ИмяСобытияЖУрнала,ИСТИНА);
	Если ДанныеПУ = Неопределено 
		Или ДанныеПУ.Количество() = 0 Тогда
		ИсторияРаботы_ВызовСервера.ЗаписьИстории(ИмяСобытияЖУрнала,"", ИСТИНА);
		Возврат;
	КонецЕсли;
	Если ДанныеПУ.Количество() > 0 Тогда
		ДанныеЗаявки = ДанныеПУ[0]; 
		ЗаполнитьЗначенияСвойств(ЭтаФорма, ДанныеЗаявки);
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Заявка = Параметры.Заявка
КонецПроцедуры

&НаКлиенте
Процедура ФормаСохранить(Команда)
	НачатьСохранение()
КонецПроцедуры

&НаКлиенте
Процедура ФормаЗакрыть(Команда)
	ЭтаФорма.Закрыть();
КонецПроцедуры

&НаКлиенте
Асинх Процедура НачатьСохранение()
	ЕстьСвязь = Ждать http_Клиент.ЕстьСвязь();
	Если Не ЕстьСвязь Тогда Возврат КонецЕсли;
	НовыеДанные = Новый Структура("Транспорт,Водитель,НомерПломбы,Контейнер");
	НовыеДанные.Транспорт = НомерАвто;
	НовыеДанные.Водитель = Водитель;
	НовыеДанные.НомерПломбы = НомерПломбы;
	НовыеДанные.Контейнер = Контейнер;
	
	Если ОбщегоНазначенияКлиентПовтИсп.ЭтоERP() Тогда 
		Запись = Новый ЗаписьJSON;
		Запись.УстановитьСтроку(Новый ПараметрыЗаписиJSON);
		ЗаписатьJSON(Запись, НовыеДанные);
		Ответ = Ждать http_Клиент.post_Асинх("/hs/ma_bgp/shipment/"+XMLСтрока(Заявка),, Запись.Закрыть());
	Иначе
		//ДанныеАвторизации = http_ПовтИсп.ДанныеАвторизации();
		//Соединение = http.СоединениеПУ(http.СвойстваСоединения(ДанныеАвторизации));
		//АдресЗапроса = "/odata/standard.odata/InformationRegister_ЗаявкиНаПогрузку(Заявка_Key=guid'"+XMLСтрока(Заявка)+"')?$format=json";
		//Запрос = http.НовыйЗапросПУ(АдресЗапроса, ДанныеАвторизации.Логин);
		//ТекстЗапроса = odata.ЗаписатьВСтрокуJSON(НовыеДанные);
		//Запрос.УстановитьТелоИзСтроки(ТекстЗапроса);
		//Ответ = Соединение.ВызватьHTTPМетод("PATCH", Запрос);
	КонецЕсли;
    ЭтаФорма.Закрыть()
КонецПроцедуры

&НаКлиенте
Асинх Процедура ВодительОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	мДанныеВыбора = Ждать ПолучитьСписокВодителей(Текст);
	Если мДанныеВыбора.Количество() = 0 Тогда Возврат КонецЕсли;
	СтандартнаяОбработка = ЛОЖЬ; 
	Водитель = Ждать ВыбратьИзСпискаАсинх(мДанныеВыбора, Элементы.Водитель);
КонецПроцедуры

&НаКлиенте
Асинх Функция ПолучитьСписокВодителей(ТекстПоля) 
	ЕстьСвязь = Ждать http_Клиент.ЕстьСвязь();
	Если Не ЕстьСвязь Тогда Возврат Новый СписокЗначений КонецЕсли;
	
	ИмяСобытияЖурнала = "ПолучениеДанныеТС";
	
	СтруктураЗапроса = УКО.НоваяСтруктураПроизвольногоЗапроса();
	Если ОбщегоНазначенияКлиентПовтИсп.ЭтоERP() Тогда
		СтруктураЗапроса.ТекстЗапроса = 
		"ВЫБРАТЬ Первые 10
		|	ФизическиеЛица.Наименование КАК Наименование
		|ИЗ
		|	Справочник.ФизическиеЛица КАК ФизическиеЛица
		|ГДЕ
		|	ФизическиеЛица.Наименование ПОДОБНО &НачалоНаименования или ФизическиеЛица.Наименование ПОДОБНО &Наименование"
	Иначе
	КонецЕсли;
	СтруктураЗапроса.ПараметрыЗапроса.Вставить("НачалоНаименования", ТекстПоля+"%");
	СтруктураЗапроса.ПараметрыЗапроса.Вставить("Наименование", ТекстПоля);


	ДанныеПУ = УКО.ПолучитьДанныеПроизвольногоЗапроса(СтруктураЗапроса,,ИмяСобытияЖУрнала,ИСТИНА);
	ДанныеВыбора = Новый СписокЗначений;
	Для Каждого стр из ДанныеПУ Цикл
		ДанныеВыбора.Добавить(стр.Наименование);	
	КонецЦикла;
	Возврат ДанныеВыбора
КонецФункции

&НаКлиенте
Процедура ВодительИзменениеТекстаРедактирования(Элемент, Текст, СтандартнаяОбработка)
	//ВыбратьВодителяизСписока(Текст)
КонецПроцедуры

&НаКлиенте
Асинх Процедура ВыбратьВодителяизСписка(Текст)
	ДанныеВыбора = Ждать ПолучитьСписокВодителей(Текст);
	Если ДанныеВыбора.Количество() = 0 Тогда Возврат КонецЕсли;
	СтандартнаяОбработка = ЛОЖЬ; 
	Водитель = Ждать ВыбратьИзСпискаАсинх(ДанныеВыбора, Элементы.Водитель);
КонецПроцедуры

&НаКлиенте
Асинх Функция ПолучитьСписокТС(ТекстПоля) 
	ЕстьСвязь = Ждать http_Клиент.ЕстьСвязь();
	Если Не ЕстьСвязь Тогда Возврат Новый СписокЗначений КонецЕсли;
	
	ИмяСобытияЖурнала = "ПолучениеДанныеТС";
	
	СтруктураЗапроса = УКО.НоваяСтруктураПроизвольногоЗапроса();
	Если ОбщегоНазначенияКлиентПовтИсп.ЭтоERP() Тогда
		СтруктураЗапроса.ТекстЗапроса = 
		"ВЫБРАТЬ Первые 10
		|	спр.Наименование КАК Наименование
		|ИЗ
		|	Справочник.ТранспортныеСредства КАК спр
		|ГДЕ
		|	спр.Наименование ПОДОБНО &НачалоНаименования или спр.Наименование ПОДОБНО &Наименование"
	Иначе
	КонецЕсли;
	СтруктураЗапроса.ПараметрыЗапроса.Вставить("НачалоНаименования", ТекстПоля+"%");
	СтруктураЗапроса.ПараметрыЗапроса.Вставить("Наименование", ТекстПоля);


	ДанныеПУ = УКО.ПолучитьДанныеПроизвольногоЗапроса(СтруктураЗапроса,,ИмяСобытияЖУрнала,ИСТИНА);
	ДанныеВыбора = Новый СписокЗначений;
	Для Каждого стр из ДанныеПУ Цикл
		ДанныеВыбора.Добавить(стр.Наименование);	
	КонецЦикла;
	Возврат ДанныеВыбора
КонецФункции



&НаКлиенте
Асинх Процедура НомерАвтоОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	мДанныеВыбора = Ждать ПолучитьСписокТС(Текст);
	Если мДанныеВыбора.Количество() = 0 Тогда Возврат КонецЕсли;
	СтандартнаяОбработка = ЛОЖЬ; 
	НомерАвто = Ждать ВыбратьИзСпискаАсинх(мДанныеВыбора, Элементы.НомерАвто);
КонецПроцедуры

