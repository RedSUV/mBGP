Функция СвойстваПакета(Пакет) Экспорт 
	УстановитьПривилегированныйРежим(ИСТИНА);
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	VLP_ПакетыСортировки.Ссылка КАК Ссылка,
	|	VLP_ПакетыСортировки.Код КАК Код,
	|	VLP_ПакетыСортировки.Наименование КАК Наименование,
	|	VLP_ПакетыСортировки.ДатаВыпуска КАК ДатаВыпуска,
	|	VLP_СведенияОПакетеСрезПоследних.Длина КАК Длина,
	|	VLP_СведенияОПакетеСрезПоследних.Сечение КАК Сечение,
	|	VLP_СведенияОПакетеСрезПоследних.ТипРаспилаЦентральнойДоски КАК ТипРаспила,
	|	VLP_СведенияОПакетеСрезПоследних.СортПиломатериалов КАК Сорт,
	|	VLP_СведенияОПакетеСрезПоследних.Объем КАК Объем,
	|	VLP_СведенияОПакетеСрезПоследних.КоличествоШтук КАК Штук,
	|	VLP_СведенияОПакетеСрезПоследних.Влажность КАК Влажность,
	|	VLP_СведенияОПакетеСрезПоследних.ВидПродукции КАК ВидПродукции,
	|	VLP_СведенияОПакетеСрезПоследних.ДляВнутреннегоРынка КАК ДляВнутреннегоРынка,
	|	VLP_СведенияОПакетеСрезПоследних.Сечение.ШтукВПакетеСухих КАК СечениеШтукВПакетеСухих,
	|	VLP_СведенияОПакетеСрезПоследних.Сечение.ТолщинаПакетаСухих КАК СечениеТолщинаПакетаСухих
	|ИЗ
	|	Справочник.VLP_ПакетыСортировки КАК VLP_ПакетыСортировки
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.VLP_СведенияОПакете.СрезПоследних КАК VLP_СведенияОПакетеСрезПоследних
	|		ПО (VLP_СведенияОПакетеСрезПоследних.НомерПакета = VLP_ПакетыСортировки.Ссылка)
	|ГДЕ
	|	VLP_ПакетыСортировки.Ссылка = &Пакет";
	Запрос.УстановитьПараметр("Пакет", Пакет);
	Выборка = Запрос.Выполнить().Выбрать();
	Выборка.Следующий();
	Возврат Выборка;
КонецФункции

Функция СвойстваПакетаПоНомеру(НомерПакета) Экспорт
	УстановитьПривилегированныйРежим(ИСТИНА);
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	VLP_ПакетыСортировки.Ссылка КАК Ссылка,
	|	VLP_ПакетыСортировки.Код КАК Код,
	|	VLP_ПакетыСортировки.Наименование КАК Наименование,
	|	VLP_ПакетыСортировки.ДатаВыпуска КАК ДатаВыпуска,
	|	VLP_СведенияОПакетеСрезПоследних.Длина КАК Длина,
	|	VLP_СведенияОПакетеСрезПоследних.Сечение КАК Сечение,
	|	VLP_СведенияОПакетеСрезПоследних.ТипРаспилаЦентральнойДоски КАК ТипРаспила,
	|	VLP_СведенияОПакетеСрезПоследних.СортПиломатериалов КАК Сорт,
	|	VLP_СведенияОПакетеСрезПоследних.Объем КАК Объем,
	|	VLP_СведенияОПакетеСрезПоследних.КоличествоШтук КАК Штук,
	|	VLP_СведенияОПакетеСрезПоследних.Влажность КАК Влажность,
	|	VLP_СведенияОПакетеСрезПоследних.ВидПродукции КАК ВидПродукции,
	|	VLP_СведенияОПакетеСрезПоследних.ДляВнутреннегоРынка КАК ДляВнутреннегоРынка,
	|	VLP_СведенияОПакетеСрезПоследних.Сечение.ШтукВПакетеСухих КАК СечениеШтукВПакетеСухих,
	|	VLP_СведенияОПакетеСрезПоследних.Сечение.ТолщинаПакетаСухих КАК СечениеТолщинаПакетаСухих
	|ИЗ
	|	Справочник.VLP_ПакетыСортировки КАК VLP_ПакетыСортировки
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.VLP_СведенияОПакете.СрезПоследних КАК VLP_СведенияОПакетеСрезПоследних
	|		ПО (VLP_СведенияОПакетеСрезПоследних.НомерПакета = VLP_ПакетыСортировки.Ссылка)
	|ГДЕ
	|	VLP_ПакетыСортировки.Код = &НомерПакета";
	Запрос.УстановитьПараметр("НомерПакета", НомерПакета);
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Возврат Выборка
	Иначе
		Возврат Неопределено
	КонецЕсли;
	
КонецФункции  
