// Функция get
// 
// Параметры: Адрес
//  Адрес - Строка - Адрес вызова
//  СоединениеПУ - Неопределено - Соединение ПУ
//  ДанныеАвторизации - Неопределено - Данные авторизации
//  ИмяВыходногоФайла - Неопределено - Имя выходного файла
//  ДопЗаголовки - Неопределено - Доп заголовки
//  Таймаут - Неопределено - Таймаут
// 
// Возвращаемое значение:
//  Неопределено, HTTPОтвет - Get
Функция get(Адрес, СоединениеПУ = Неопределено, ДанныеАвторизации = Неопределено, ИмяВыходногоФайла = НЕОПРЕДЕЛЕНО, ДопЗаголовки = НЕОПРЕДЕЛЕНО, Таймаут = НЕОПРЕДЕЛЕНО) Экспорт
	Результат = ВыполнитьЗапрос(Адрес, "GET", , СоединениеПУ, ДанныеАвторизации, ИмяВыходногоФайла, ДопЗаголовки, Таймаут);
	Возврат Результат
КонецФункции

// Post.
// 
// Параметры:
//  Адрес - Строка - Адрес вызова
//  ДанныеТела - Неопределено - Данные тела
//  СоединениеПУ - Неопределено - Соединение ПУ
//  ДанныеАвторизации - Неопределено - Данные авторизации
//  ИмяВыходногоФайла - Неопределено - Имя выходного файла
//  ДопЗаголовки - Неопределено - Доп заголовки
//  Таймаут - Неопределено - Таймаут
// 
// Возвращаемое значение:
//  Неопределено, HTTPОтвет - Post
Функция post(Адрес, ДанныеТела=НЕОПРЕДЕЛЕНО, СоединениеПУ = Неопределено, ДанныеАвторизации = Неопределено, ИмяВыходногоФайла = НЕОПРЕДЕЛЕНО, ДопЗаголовки = НЕОПРЕДЕЛЕНО, Таймаут = НЕОПРЕДЕЛЕНО) Экспорт
	Результат = ВыполнитьЗапрос(Адрес, "POST", ДанныеТела, СоединениеПУ, ДанныеАвторизации, ИмяВыходногоФайла, ДопЗаголовки, Таймаут);	
	Возврат Результат
КонецФункции

// Patch.
// 
// Параметры:
//  Адрес - Строка - Адрес вызова
//  ДанныеТела - Неопределено - Данные тела
//  СоединениеПУ - Неопределено - Соединение ПУ
//  ДанныеАвторизации - Неопределено - Данные авторизации
//  ИмяВыходногоФайла - Неопределено - Имя выходного файла
//  ДопЗаголовки - Неопределено - Доп заголовки
//  Таймаут - Неопределено - Таймаут
// 
// Возвращаемое значение:
//  Неопределено, HTTPОтвет - Patch
Функция patch(Адрес, ДанныеТела=НЕОПРЕДЕЛЕНО, СоединениеПУ = Неопределено, ДанныеАвторизации = Неопределено, ИмяВыходногоФайла = НЕОПРЕДЕЛЕНО, ДопЗаголовки = НЕОПРЕДЕЛЕНО, Таймаут = НЕОПРЕДЕЛЕНО) Экспорт
	Результат = ВыполнитьЗапрос(Адрес, "PATCH", ДанныеТела, СоединениеПУ, ДанныеАвторизации, ИмяВыходногоФайла, ДопЗаголовки, Таймаут);	
	Возврат Результат
КонецФункции

// Выполнить запрос.
// 
// Параметры:
//  Адрес - Строка - Адрес
//  HTTPМетод - Строка - HTTPМетод
//  ДанныеТела - Неопределено, Строка - Данные тела
//  СоединениеПУ - Неопределено - Соединение ПУ
//  ДанныеАвторизации - Структура, Неопределено - Данные авторизации:
// * Путь - Произвольный, СправочникСсылка.БазыПУ - 
// * Логин - Произвольный, Строка - 
// * Пароль - Произвольный, Строка - 
//  ИмяВыходногоФайла - Неопределено - Имя выходного файла
//  ДопЗаголовки - Соответствие, Неопределено - Доп заголовки
//  Таймаут - Неопределено - Таймаут
// 
// Возвращаемое значение:
//  HTTPОтвет, Неопределено - Выполнить запрос
Функция ВыполнитьЗапрос(Адрес, HTTPМетод, ДанныеТела=НЕОПРЕДЕЛЕНО, СоединениеПУ = Неопределено, Знач ДанныеАвторизации = Неопределено, ИмяВыходногоФайла = НЕОПРЕДЕЛЕНО, ДопЗаголовки = НЕОПРЕДЕЛЕНО, Таймаут = НЕОПРЕДЕЛЕНО) 
	
	Если ДанныеАвторизации = Неопределено Тогда
		ДанныеАвторизации = http_ПовтИсп.ДанныеАвторизации();	
	КонецЕсли;
	
	Если СоединениеПУ = Неопределено Тогда
		СоединениеПУ = СоединениеПУ(СвойстваСоединения(ДанныеАвторизации), Таймаут);
	КонецЕсли;
	
	HTTPЗапрос = НовыйЗапросПУ(Адрес, ДанныеАвторизации.Логин, ДопЗаголовки);
	
	Если Не ДанныеТела = НЕОПРЕДЕЛЕНО Тогда
		Если ТипЗнч(ДанныеТела) = Тип("Строка") Тогда
			HTTPЗапрос.УстановитьТелоИзСтроки(ДанныеТела);
		Иначе
			HTTPЗапрос.УстановитьТелоИзСтроки(json.ЗаписатьВСтрокуJSON_СериализаторXDTO(ДанныеТела));
		КонецЕсли;
	КонецЕсли;
	
	Попытка 
		НачалоЗамера = ТекущаяУниверсальнаяДатаВМиллисекундах();
		Ответ = СоединениеПУ.ВызватьHTTPМетод(HTTPМетод, HTTPЗапрос, ИмяВыходногоФайла);
		Если Ответ.КодСостояния = 200 Тогда
			
			Ответ.Заголовки.Вставить("show_time", ТекущаяУниверсальнаяДатаВМиллисекундах() - НачалоЗамера);		
			
		ИначеЕсли Ответ.КодСостояния = 301 или Ответ.КодСостояния = 302 Тогда
			АдресПереадресации	 = Ответ.Заголовки.Получить("Location");
			КукиПереадресации	 = Ответ.Заголовки.Получить("Set-Cookie");
			Если НЕ КукиПереадресации = Неопределено Тогда
				Если ДопЗаголовки = Неопределено Тогда
					ДопЗаголовки = Новый Соответствие;	
				КонецЕсли;
				ДопЗаголовки.Вставить("Set-Cookie", КукиПереадресации);	
			КонецЕсли;
			
			Нов = РазобратьАдрес(АдресПереадресации);
			ДанныеАвторизации.Путь = Нов.Сервер;
			HTTPЗапрос = НовыйЗапросПУ(Нов.Адрес, ДанныеАвторизации.Логин, ДопЗаголовки);
			
			Ответ = ВыполнитьЗапрос(Нов.Адрес, HTTPМетод, ДанныеТела, Неопределено, ДанныеАвторизации, ИмяВыходногоФайла, ДопЗаголовки);
			
		ИначеЕсли Ответ.КодСостояния = 401 Тогда
			
			Ответ.Заголовки.Вставить("show_time", ТекущаяУниверсальнаяДатаВМиллисекундах() - НачалоЗамера);		
			
		Иначе
			ТекстОшибки =  Ответ.ПолучитьТелоКакСтроку("windows-1251");
			Ответ = Неопределено;
		КонецЕсли;
		
	Исключение
		Ответ = Неопределено;
		ТекстОшибки = ОписаниеОшибки();
	КонецПопытки;                
	
	Если Ответ = Неопределено Тогда
		ЗаписьИстории(СтрШаблон("%1:%2",HTTPМетод,Адрес), ТекстОшибки, ИСТИНА);
	КонецЕсли;
	
	Возврат Ответ;
КонецФункции

Функция НовыйЗапросПУ(Адрес, Логин, Заголовки = НЕОПРЕДЕЛЕНО) Экспорт
	
	Если Заголовки = Неопределено Тогда
		Заголовки = Новый Соответствие;
	КонецЕсли;
	ТипКодировки = ТипКодировки();
	Заголовки.Вставить("Content-Type", "charset="+ТипКодировки); 
	
	Если Заголовки.Получить("Accept-Encoding") = Неопределено Тогда
		Заголовки.Вставить("Accept-Encoding","zip");
	КонецЕсли;
	
	Для Каждого м из http_ПовтИсп.ЗаголовкиЗапроса() Цикл
		Заголовки.Вставить(м.Ключ, КодироватьСтроку(м.Значение, СпособКодированияСтроки.КодировкаURL, ТипКодировки));	
	КонецЦикла;
	//Заголовки.Вставить("Geo_location", ПараметрыСеанса.ТекущееМестоположение);
	
	Заголовки.Вставить("Login", КодироватьСтроку(Логин, СпособКодированияСтроки.КодировкаURL, ТипКодировки));	
	
	Запрос = Новый HTTPЗапрос(Адрес, Заголовки);
		
	Возврат Запрос;	
	
КонецФункции

Функция СвойстваСоединения(ДанныеАвторизации) Экспорт
	
	СерверАдреса = ДанныеАвторизации.Путь.Адрес;
	ЗащищСоединение = ДанныеАвторизации.Путь.https;
	
	Ответ = Новый Структура();
	Ответ.Вставить("Сервер", СерверАдреса);
	Ответ.Вставить("Логин", ДанныеАвторизации.Логин);
	Ответ.Вставить("Пароль", ДанныеАвторизации.Пароль);
	Ответ.Вставить("ЗащищСоединение", ЗащищСоединение);
	
	Возврат Ответ
КонецФункции

Функция СоединениеПУ(м, Таймаут = 10) Экспорт
	
	Соединение = Новый HTTPСоединение(м.Сервер, , м.Логин, м.Пароль, ,Таймаут, м.ЗащищСоединение);	
	
	Возврат Соединение;
КонецФункции

Функция ЕстьСвязь() Экспорт
	Возврат ping(ОбщегоНазначенияВызовСервераПовтИсп.БазаПУ());
КонецФункции

Функция ping(Адрес) Экспорт
	Если Адрес = Неопределено Тогда
		Адрес = Константы.АдресПУ.Получить();
	КонецЕсли;
	Если Не ЗначениеЗаполнено(Адрес) Тогда
		Возврат ЛОЖЬ
	КонецЕсли;
	Соединение = Новый HTTPСоединение(Адрес.АдресДляPing,,,,,5,?(Адрес.https, Новый ЗащищенноеСоединениеOpenSSL, НЕОПРЕДЕЛЕНО));
	Попытка
		Ответ = Соединение.Получить(Новый HTTPЗапрос());
		Возврат Ответ.КодСостояния = 200
	Исключение
		Возврат ЛОЖЬ
	КонецПопытки;
		
КонецФункции

Функция ТипКодировки(ЗапросОтвет = Неопределено) Экспорт
	КодировкаУмолч = "utf-8";
	Если ЗапросОтвет = Неопределено Тогда Возврат КодировкаУмолч КонецЕсли;
	
	ОписаниеКодировки = ЗапросОтвет.Заголовки.Получить("Content-Type");
	Если ОписаниеКодировки = Неопределено Тогда
		Возврат КодировкаУмолч;
	Иначе
		м_Content_Type = СтрРазделить(ОписаниеКодировки, ";");
		Для Каждого м из м_Content_Type Цикл
			т = СокрЛП(м);
			Если Лев(т, 7) = "charset" Тогда
				Возврат Сред(т, 9);
			КонецЕсли;
		КонецЦикла;
		Возврат КодировкаУмолч	
	КонецЕсли;
КонецФункции

Функция РазобратьАдрес(Знач АдресСтрокой) Экспорт
	Ответ = Новый Структура("Сервер, Адрес, ЗащищенноеСоединение","","",ЛОЖЬ);
	Если Лев(АдресСтрокой, СтрДлина("http://")) = "http://" Тогда
		Ответ.ЗащищенноеСоединение = ЛОЖЬ;
		АдресСтрокой = Сред(АдресСтрокой, СтрДлина("http://")+1); 
	ИначеЕсли Лев(АдресСтрокой, СтрДлина("https://")) = "https://" Тогда
		Ответ.ЗащищенноеСоединение = ИСТИНА;
		АдресСтрокой = Сред(АдресСтрокой, СтрДлина("https://")+1);
	КонецЕсли;
	НомерРазделителяСерверАдрес = СтрНайти(АдресСтрокой, "/", НаправлениеПоиска.СКонца);
	Если НомерРазделителяСерверАдрес > 0 Тогда
		Ответ.Сервер = Лев(АдресСтрокой, НомерРазделителяСерверАдрес-1);	
		Ответ.Адрес	 = Сред(АдресСтрокой, НомерРазделителяСерверАдрес+1);
	КонецЕсли;
	
	Возврат Ответ;
	
КонецФункции

Функция ИзвлечьДанныеИзОтветаСервера(Ответ) Экспорт
	Кодировка = ТипКодировки(Ответ);
	ТипОтвета = Ответ.Заголовки.Получить("Accept-Encoding");
	СтрокаОтвета = Ответ.ПолучитьТелоКакСтроку(Кодировка);
	
	Возврат ИзвлечьДанныеИзСтрокиОтветаСервера(СтрокаОтвета, ТипОтвета)
	
КонецФункции

Функция ИзвлечьДанныеИзСтрокиОтветаСервера(СтрокаОтвета, ТипОтвета) Экспорт
	Если ТипОтвета = "json" Тогда
		СтрокаJson = СтрокаОтвета;
	Иначе
		СтрокаJson = XMLЗначение(Тип("ХранилищеЗначения"), СтрокаОтвета).Получить();
	КонецЕсли;
	
	Возврат json.ПрочитатьДанныеJSONизСтроки(СтрокаJson);
КонецФункции