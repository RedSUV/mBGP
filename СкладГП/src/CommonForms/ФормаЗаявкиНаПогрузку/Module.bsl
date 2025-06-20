
&НаКлиенте
Процедура ТелефонВодителяНажатие(Элемент, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура ВодительНажатие(Элемент, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Не http.ЕстьСвязь() Тогда Отказ = ИСТИНА; Возврат КонецЕсли;
	
	Если ЗначениеЗаполнено(Параметры.Заявка) Тогда
		Заявка = Параметры.Заявка;
	Иначе
		Отказ = ИСТИНА;
		Возврат 
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ОбновитьЗаголовокФормы()
	Заголовок = "Заявка "+ОбщегоНазначения.НомерНаПечать(Номер)+" на "+НомерАвто;
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ЗаполнитьДанныеЗаявки() Экспорт
	 ЗаполнитьДанныеЗаявки();	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДанныеЗаявки()

	Если Не http.ЕстьСвязь() Тогда Возврат КонецЕсли;
	
	ИмяСобытияЖурнала = "ОбновитьДанныеЗаявкиНаПогрузку";
	
	СтруктураЗапроса = УКО.НоваяСтруктураПроизвольногоЗапроса(); 
	Если ОбщегоНазначенияВызовСервераПовтИсп.БазаПУ().ЭтоERP Тогда
		СтруктураЗапроса.ТекстЗапроса = 
		"ВЫБРАТЬ
		|	УНИКАЛЬНЫЙИДЕНТИФИКАТОР(VLP_ЗаявкаНаПогрузку.Ссылка) КАК Заявка,
		|	VLP_ЗаявкаНаПогрузку.Номер КАК Номер,
		|	VLP_ЗаявкаНаПогрузку.Дата КАК Дата,
		|	VLP_ЗаявкаНаПогрузку.ВидМультиМаршрута.Наименование КАК ВидМультиМаршрута,
		|	VLP_ЗаявкаНаПогрузку.Водитель.Наименование КАК ВодительНаименование,
		|	VLP_ЗаявкаНаПогрузку.Соглашение.Наименование КАК ДопСоглашение,
		|	VLP_ЗаявкаНаПогрузку.Задание_Текст КАК Задание_Текст,
		|	УНИКАЛЬНЫЙИДЕНТИФИКАТОР(VLP_ЗаявкаНаПогрузку.ИнструкцияФотографирования) КАК ИнструкцияФотографирования,
		|	VLP_ЗаявкаНаПогрузку.Контейнер.Наименование КАК Контейнер,
		|	VLP_ЗаявкаНаПогрузку.Транспорт.Наименование КАК НомерАвто,
		|	VLP_ЗаявкаНаПогрузку.Транспорт.Марка КАК МаркаТранспорта,
		|	VLP_ЗаявкаНаПогрузку.ПланДатаПогрузки КАК ПланДатаПогрузки,
		|	VLP_ЗаявкаНаПогрузку.Контрагент.Наименование КАК Покупатель,
		|	VLP_ЗаявкаНаПогрузку.Перевозчик.Наименование КАК Перевозчик
		|ИЗ
		|	Документ.pu_ЗаявкаНаПогрузку КАК VLP_ЗаявкаНаПогрузку
		|ГДЕ
		|	УНИКАЛЬНЫЙИДЕНТИФИКАТОР(VLP_ЗаявкаНаПогрузку.Ссылка) = &ЗаявкаНаПогрузку";	
	Иначе
		СтруктураЗапроса.ТекстЗапроса = 
		"ВЫБРАТЬ
		|	УНИКАЛЬНЫЙИДЕНТИФИКАТОР(VLP_ЗаявкаНаПогрузку.Ссылка) КАК Заявка,
		|	VLP_ЗаявкаНаПогрузку.Номер КАК Номер,
		|	VLP_ЗаявкаНаПогрузку.Дата КАК Дата,
		|	VLP_ЗаявкаНаПогрузку.ВидМультиМаршрута.Наименование КАК ВидМультиМаршрута,
		|	VLP_ЗаявкаНаПогрузку.Водитель.Наименование КАК ВодительНаименование,
		|	VLP_ЗаявкаНаПогрузку.ДопСоглашение.Наименование КАК ДопСоглашение,
		|	VLP_ЗаявкаНаПогрузку.Задание_Текст КАК Задание_Текст,
		|	УНИКАЛЬНЫЙИДЕНТИФИКАТОР(VLP_ЗаявкаНаПогрузку.ИнструкцияФотографирования) КАК ИнструкцияФотографирования,
		|	VLP_ЗаявкаНаПогрузку.Контейнер КАК Контейнер,
		|	VLP_ЗаявкаНаПогрузку.НомерАвто КАК НомерАвто,
		|	VLP_ЗаявкаНаПогрузку.МаркаТранспорта КАК МаркаТранспорта,
		|	VLP_ЗаявкаНаПогрузку.ПланДатаПогрузки КАК ПланДатаПогрузки,
		|	VLP_ЗаявкаНаПогрузку.Покупатель.Наименование КАК Покупатель,
		|	VLP_ЗаявкаНаПогрузку.Перевозчик.Наименование КАК Перевозчик
		|ИЗ
		|	Документ.VLP_ЗаявкаНаПогрузку КАК VLP_ЗаявкаНаПогрузку
		|ГДЕ
		|	УНИКАЛЬНЫЙИДЕНТИФИКАТОР(VLP_ЗаявкаНаПогрузку.Ссылка) = &ЗаявкаНаПогрузку";
	КонецЕсли;
	СтруктураЗапроса.ПараметрыЗапроса.Вставить("ЗаявкаНаПогрузку", Заявка);

	ДанныеПУ = УКО.ПолучитьДанныеПроизвольногоЗапроса(СтруктураЗапроса,,ИмяСобытияЖУрнала);
	Если ДанныеПУ = Неопределено 
		Или ДанныеПУ.Количество() = 0 Тогда
		ЗаписьИстории(ИмяСобытияЖУрнала,"", ИСТИНА);
		Возврат;
	КонецЕсли;
	Если ДанныеПУ.Количество() > 0 Тогда
		ДанныеЗаявки = ДанныеПУ[0]; 
		ЗаполнитьЗначенияСвойств(ЭтаФорма, ДанныеЗаявки);
		Если ЗначениеЗаполнено(ДанныеЗаявки.ИнструкцияФотографирования) Тогда
			ИнструкцияФотографирования = Справочники.ИнструкцииФотографирования.ПолучитьСсылку(ДанныеЗаявки.ИнструкцияФотографирования);
			Если Не ЗначениеЗаполнено(ИнструкцияФотографирования) Тогда
				а=1;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	ДвоичныеДанныеФото = РегистрыСведений.ДвоичныеДанныеПрисоединенныхФайлов.СоздатьНаборЗаписей();
	ДвоичныеДанныеФото.Отбор.ID_Ссылки.Установить(Заявка);
	ДвоичныеДанныеФото.Прочитать();
	Для Каждого стр из ДвоичныеДанныеФото Цикл
		Попытка
			ЭтотОбъект[стр.Наименование] = ПоместитьВоВременноеХранилище(Base64Значение(стр.Base64), УникальныйИдентификатор);
		Исключение
		КонецПопытки
	КонецЦикла;
	
	НастроитьСтраницуФотоПоИнструкции();
	ОбновитьЗаголовокФормы();
КонецПроцедуры

&НаСервере
Процедура НастроитьСтраницуФотоПоИнструкции()
	Если ЗначениеЗаполнено(ИнструкцияФотографирования) Тогда
		МаксНомер = 0;
		Для Каждого стр из ИнструкцияФотографирования.Инструкция Цикл
			ЭлементФото = Элементы["Фотография"+стр.НомерСтроки];
			МаксНомер = Макс(МаксНомер,стр.НомерСтроки);
			Если ЭлементФото = Неопределено Тогда Продолжить КонецЕсли;
			ЭлементФото.ТекстНевыбраннойКартинки = стр.КраткоеОписание;
		КонецЦикла;	
		Для инд = МаксНомер+1 по 10 Цикл
			ЭлементФото = Элементы["Фотография"+инд];
			ЭлементФото.ТекстНевыбраннойКартинки = "--доп.фото--"; 
		КонецЦикла;
		
	Конецесли;
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДанныеПредварительной()

	ИмяСобытияЖурнала = "ОбновитьДанныеПредварительнойЗаявкиНаПогрузку";
	
	СтруктураЗапроса = УКО.НоваяСтруктураПроизвольногоЗапроса();
	Если ОбщегоНазначенияВызовСервераПовтИсп.БазаПУ().ЭтоERP Тогда
		СтруктураЗапроса.ТекстЗапроса = 
		"ВЫБРАТЬ
		|	УНИКАЛЬНЫЙИДЕНТИФИКАТОР(ПредварительнаяТовары.НомерПакета) КАК Пакет,
		|	ПредварительнаяТовары.НомерПакета.Код КАК НомерПакета,
		|	ПредварительнаяТовары.НомерПакета.ДатаВыпуска КАК ДатаВыпуска,
		|	ПредварительнаяТовары.НомерПакета.Досок КАК Досок,
		|	ПредварительнаяТовары.Сечение.Наименование КАК Сечение,
		|	ПредварительнаяТовары.Объем КАК Объем,
		|	0 КАК НомерНаСхемеПогрузки
		|ИЗ
		|	Документ.pu_ЗаявкаНаПогрузку.ДетальноеОписание КАК ПредварительнаяТовары
		|ГДЕ
		|	УНИКАЛЬНЫЙИДЕНТИФИКАТОР(ПредварительнаяТовары.Ссылка) = &ЗаявкаНаПогрузку";
	Иначе
		СтруктураЗапроса.ТекстЗапроса = 
		"ВЫБРАТЬ
		|	УНИКАЛЬНЫЙИДЕНТИФИКАТОР(ПредварительнаяТовары.НомерПакета) КАК Пакет,
		|	ПредварительнаяТовары.НомерПакета.Код КАК НомерПакета,
		|	ПредварительнаяТовары.НомерПакета.ДатаВыпуска КАК ДатаВыпуска,
		|	ПредварительнаяТовары.КоличествоШтук КАК Досок,
		|	ПредварительнаяТовары.Сечение.Наименование КАК Сечение,
		|	ПредварительнаяТовары.Объем КАК Объем,
		|	ПредварительнаяТовары.НомерНаСхемеПогрузки КАК НомерНаСхемеПогрузки
		|ИЗ
		|	Документ.VLP_ПредварительнаяОтгрузка.Товары КАК ПредварительнаяТовары
		|ГДЕ
		|	УНИКАЛЬНЫЙИДЕНТИФИКАТОР(ПредварительнаяТовары.Ссылка.ЗаявкаНаПогрузку) = &ЗаявкаНаПогрузку"; 
	КонецЕсли;
	СтруктураЗапроса.ПараметрыЗапроса.Вставить("ЗаявкаНаПогрузку", Заявка);

	ДанныеПУ = УКО.ПолучитьДанныеПроизвольногоЗапроса(СтруктураЗапроса,,ИмяСобытияЖУрнала);
	Если ДанныеПУ = Неопределено 
		//Или ДанныеПУ.Количество() = 0 
		Тогда
		ЗаписьИстории(ИмяСобытияЖУрнала,"", ИСТИНА);
		Возврат;
	КонецЕсли;
	ДанныеПредварительной.Очистить();
	Для Каждого стр из ДанныеПУ Цикл
		Нов = ДанныеПредварительной.Добавить();
		ЗаполнитьЗначенияСвойств(Нов, стр);
		Нов.Объем = Нов.Объем+" м3";
		Нов.Досок = Нов.Досок+" шт";
		Нов.Адрес = ЯчейкиСкладаВызовСервера.ТекущийАдресПакета(Нов.Пакет);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ЗаполнитьДанныеПредварительной() Экспорт 
	Если ЕстьСвязь Тогда
		ЗаполнитьДанныеПредварительной()	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ЗаполнитьДанныеФото() Экспорт
			
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	НастроитьФормуНаКлиенте(Истина);
	ПодключитьОбработчикОжидания("Подключаемый_ЗаполнитьДанныеЗаявки", 0.5, ИСТИНА);
	ПодключитьОбработчикОжидания("Подключаемый_ЗаполнитьДанныеПредварительной", 0.5, ИСТИНА); 
	ПодключитьОбработчикОжидания("Подключаемый_ЗаполнитьДанныеФото", 1, ИСТИНА);
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьДвоичныеДанныеПрисоединенногоФайла(ЭлементФото, ДвоичнДанные, СохранитьКопию = ИСТИНА)
	ИмяФото = ЭлементФото.Имя;
	ЭтотОбъект[ИмяФото] = ПоместитьВоВременноеХранилище(ДвоичнДанные, УникальныйИдентификатор);
	ДвоичныеДанныеПрисоединенныхФайловВызовСервера.ЗаписатьДанные(Заявка
																, ?(ОбщегоНазначенияКлиентПовтИсп.ЭтоERP(),"Справочник.pu_ЗаявкаНаПогрузкуПрисоединенныеФайлы", "Справочник.VLP_ЗаявкаНаПогрузкуПрисоединенныеФайлы")
																, ИмяФото
																, ЭлементФото.ТекстНевыбраннойКартинки
																, "jpg"
																, ЭтотОбъект[ИмяФото]);
																
	Если СохранитьКопию Тогда
		ИмяФайлаКартинки = СтрШаблон("%1_%2.%3", XMLСтрока(Заявка), ИмяФото, "jpg");
		ОбщегоНазначенияКлиент.СохранитьКартинкуВГалереюАсинх(ДвоичнДанные, ИмяФайлаКартинки, "mBGP");	
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура ФотографияНажатие(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = ЛОЖЬ;
	#Если МобильноеПриложениеКлиент или МобильныйКлиент Тогда 
		ДМ = ПолучитьДанныеФотоСнимка();
		Если Не ДМ = Неопределено Тогда
			ДвоичнДанные = ДМ.ПолучитьДвоичныеДанные();
			ЗаписатьДвоичныеДанныеПрисоединенногоФайла(Элемент, ДвоичнДанные, ИСТИНА);
		КонецЕсли;
	#КонецЕсли	
КонецПроцедуры

&НаКлиенте
Процедура ЗапускПриложения(КодВозврата, ДополнительныйПараметр) Экспорт    
КонецПроцедуры

&НаКлиенте
Функция ПолучитьДанныеФотоСнимка()
	
	Данные = Неопределено;
	ВыводитьДатуНаФото = ОбщегоНазначенияВызовСервераПовтИсп.ВыводитьДатуНаФото();
	#Если МобильноеПриложениеКлиент или МобильныйКлиент Тогда
		
		Данные = ОбщегоНазначенияКлиент.ПолучитьДанныеФотоСнимка(Новый РазрешениеКамерыУстройства(1080, 1920), 20, ВыводитьДатуНаФото);
		
	#КонецЕсли
	
	Возврат Данные;
	
КонецФункции  

&НаКлиенте
Процедура ПриИзмененииПараметровЭкрана()
	ОбщегоНазначенияКлиент.ЗаполнитьСвойстваФормыПриИзмененииПараметровЭкрана(ЭтаФорма);

	НастроитьФормуНаКлиенте(ЛОЖЬ)
КонецПроцедуры

&НаСервере
Процедура СоздатьЭлементыФотографий()
	
	МассивДобавляемыхРеквизитов = Новый Массив;
	Для инд = 1 по 12 Цикл
		МассивДобавляемыхРеквизитов.Добавить(Новый РеквизитФормы("Фотография"+инд, Новый ОписаниеТипов("Строка")));
	КонецЦикла;
	ИзменитьРеквизиты(МассивДобавляемыхРеквизитов); 
	
	Для инд = 1 по 12 Цикл
		Нов = Элементы.Добавить("Фотография"+инд, Тип("ПолеФормы"));
		Нов.Вид = ВидПоляФормы.ПолеКартинки; 
		Нов.Гиперссылка = ИСТИНА;
		Нов.ПутьКДанным = "Фотография"+инд;  
		Нов.ТекстНевыбраннойКартинки = "Нажмите чтобы сделать доп.фото";
		
		Нов.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Нет;
		
		Нов.УстановитьДействие("Нажатие", "ФотографияНажатие");
		
		КнопкаВыбора = НоваяКнопкаКоманднойПанелиФотоВыбратьФайл(Нов);
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция НоваяКнопкаКоманднойПанелиФотоВыбратьФайл(ЭлементФото)
	
	НоваяКоманда = Команды.Добавить("ВыбратьФайл"+ЭлементФото.Имя);
	НоваяКоманда.Действие = "ВыбратьФотоИзГалереи";//Имя процедуры
	НоваяКоманда.Заголовок = "Выбрать файл";
	
	НовыйЭлемент = Элементы.Добавить("ВыбратьФайл"+ЭлементФото.Имя,
	                                 Тип("КнопкаФормы"),
									 ЭлементФото.КонтекстноеМеню);
	НовыйЭлемент.ИмяКоманды = НоваяКоманда.Имя;
	
КонецФункции

&НаСервере
Процедура НастроитьЭлементыФотографий(ЭтоПортретныйРежимЭкрана = ИСТИНА)
	Если ЭтоПортретныйРежимЭкрана Тогда
		
		Элементы.Переместить(Элементы.Фотография1,	 Элементы.ГруппаФото_1_1);
		Элементы.Переместить(Элементы.Фотография2,	 Элементы.ГруппаФото_1_1);
		
		Элементы.Переместить(Элементы.Фотография3,	 Элементы.ГруппаФото_1_2);
		Элементы.Переместить(Элементы.Фотография4,	 Элементы.ГруппаФото_1_2);
		
		Элементы.Переместить(Элементы.Фотография5,	 Элементы.ГруппаФото_2_1);
		Элементы.Переместить(Элементы.Фотография6,	 Элементы.ГруппаФото_2_1);
		
		Элементы.Переместить(Элементы.Фотография7,	 Элементы.ГруппаФото_2_2);
		Элементы.Переместить(Элементы.Фотография8,	 Элементы.ГруппаФото_2_2);
		
		Элементы.Переместить(Элементы.Фотография9,	 Элементы.ГруппаФото_3_1);
		Элементы.Переместить(Элементы.Фотография10,	 Элементы.ГруппаФото_3_1);
		
		Элементы.Переместить(Элементы.Фотография11,	 Элементы.ГруппаФото_3_2);
		Элементы.Переместить(Элементы.Фотография12,	 Элементы.ГруппаФото_3_2)
	Иначе 
		
		Элементы.Переместить(Элементы.Фотография1,	 Элементы.ГруппаФото_1_1);
		Элементы.Переместить(Элементы.Фотография2,	 Элементы.ГруппаФото_1_1);
		
		Элементы.Переместить(Элементы.Фотография3,	 Элементы.ГруппаФото_1_2);
		Элементы.Переместить(Элементы.Фотография4,	 Элементы.ГруппаФото_1_2);
		
		Элементы.Переместить(Элементы.Фотография5,	 Элементы.ГруппаФото_1_3);
		Элементы.Переместить(Элементы.Фотография6,	 Элементы.ГруппаФото_1_3);
		
		Элементы.Переместить(Элементы.Фотография7,	 Элементы.ГруппаФото_2_1);
		Элементы.Переместить(Элементы.Фотография8,	 Элементы.ГруппаФото_2_1);
		
		Элементы.Переместить(Элементы.Фотография9,	 Элементы.ГруппаФото_2_2);
		Элементы.Переместить(Элементы.Фотография10,	 Элементы.ГруппаФото_2_2);
        
		Элементы.Переместить(Элементы.Фотография11,	 Элементы.ГруппаФото_2_3);
		Элементы.Переместить(Элементы.Фотография12,	 Элементы.ГруппаФото_2_3);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НастроитьФормуНаКлиенте(ПервыйВызов = ЛОЖЬ)
	Если ПервыйВызов Тогда 
		СоздатьЭлементыФотографий();		
	КонецЕсли;
	
	НастроитьЭлементыФотографий(ОбщегоНазначенияКлиент.ЭтоПортретныйРежимЭкрана())
	
КонецПроцедуры

&НаКлиенте
Асинх Процедура ОтправитьВПУ(Команда) 
	Ответ = Ждать ВопросАсинх("Отправить изменения фотографий для отправки в ПУ?", РежимДиалогаВопрос.ДаНет);
	Если Ответ = КодВозвратаДиалога.Да Тогда
		ЗарегистрироватьИзмененияДляОтправки();
		СлужебныйОбновлениеКлиент.ОбменятьсяИзменениями();
	КонецЕсли;
КонецПроцедуры 

&НаСервере
Процедура ЗарегистрироватьИзмененияДляОтправки()
	НЗ = РегистрыСведений.ДвоичныеДанныеПрисоединенныхФайлов.СоздатьНаборЗаписей();
	НЗ.Отбор.ID_Ссылки.Установить(Заявка);
	НЗ.Прочитать();
	НЗ.Записать();
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьФотоИзГалереи(Команда)
	ИмяЭлемента = СтрЗаменить(Команда.Имя, "ВыбратьФайл", "");
	ВыбратьФотоИзГалереиАсинх(ИмяЭлемента)
КонецПроцедуры

&НаКлиенте
Асинх Процедура ВыбратьФотоИзГалереиАсинх(ИмяЭлемента)
	КаталогВыбора = Ждать КаталогДокументовАсинх();
	#Если МобильноеПриложениеКлиент или МобильныйКлиент Тогда 
		КаталогВыбора = Ждать КаталогБиблиотекиМобильногоУстройстваАсинх(ТипКаталогаБиблиотекиМобильногоУстройства.Картинки);	
	#КонецЕсли
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	Диалог.Каталог = КаталогВыбора;
	Диалог.Фильтр = "(*.jpg)|*.jpg";
	РезультатВыбора = Ждать Диалог.ВыбратьАсинх();
	Если РезультатВыбора = Неопределено Тогда
		Возврат
	Иначе
		ДвоичнДанные = Новый ДвоичныеДанные(РезультатВыбора[0]); 
		ЗаписатьДвоичныеДанныеПрисоединенногоФайла(Элементы[ИмяЭлемента], ДвоичнДанные, ЛОЖЬ);	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДействияПослеВводаДанныхТС(Результат, ДопПар) Экспорт
	ПодключитьОбработчикОжидания("Подключаемый_ЗаполнитьДанныеЗаявки", 0.5, ИСТИНА);
КонецПроцедуры

&НаКлиенте
Процедура ВнестиДанныеТС(Команда)
	Пар = Новый Структура;
	Пар.Вставить("Заявка", Заявка);
	ДействияПослеВводаДанныхТС = Новый ОписаниеОповещения("ДействияПослеВводаДанныхТС", ЭтотОбъект, Пар);
	ОткрытьФорму("ОбщаяФорма.ФормаУказанияТС", Пар, ЭтаФорма,,,,ДействияПослеВводаДанныхТС, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	//Вставить содержимое обработчика
КонецПроцедуры
