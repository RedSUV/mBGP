Функция ПакетПоврежден(Знач НомерПакета) Экспорт
	Если ТипЗнч(НомерПакета) = Тип("Строка") Тогда
		НомерПакета = Пакеты.ПолучитьИдентификаторПакетаПоСтроке(НомерПакета);	
	КонецЕсли;
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Пакет", НомерПакета);
	Запрос.Текст = 
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	ПоврежденныеПакеты.Пакет КАК Пакет
	|ИЗ
	|	РегистрСведений.ПоврежденныеПакеты КАК ПоврежденныеПакеты
	|ГДЕ
	|	ПоврежденныеПакеты.Пакет = &Пакет";
	Возврат НЕ Запрос.Выполнить().Пустой()
КонецФУнкции

Процедура ЗаписатьЗаписьРегистра(стр) Экспорт
	МенеджерСвойств = РегистрыСведений.ПоврежденныеПакеты;
	
	НовСвойство = МенеджерСвойств.СоздатьМенеджерЗаписи();
	НовСвойство.Склад				 = ОбщегоНазначенияВызовСервераПовтИсп.Склад();
	НовСвойство.Пакет				 = стр.Пакет;
	НовСвойство.ИдентификаторЗаписи	 = стр.ИдентификаторЗаписи;
	
	НовСвойство.Прочитать();
	Если НовСвойство.Выбран() Тогда
		Возврат;
	Иначе
		НовСвойство.Склад				 = ОбщегоНазначенияВызовСервераПовтИсп.Склад();
		НовСвойство.Пакет				 = стр.Пакет;
		НовСвойство.ИдентификаторЗаписи	 = стр.ИдентификаторЗаписи;
		Фото  = "";
	КонецЕсли;
	
	НовСвойство.Комментарий			 = стр.Комментарий;

	НовСвойство.ДанныеПовреждений	 = стр.ДанныеПовреждений;
	НовСвойство.ВыгруженПУ			 = ИСТИНА;
	НовСвойство.Номер				 = стр.Номер;
	НовСвойство.ДатаОбнаружения		 = стр.ДатаОбнаружения;
	
	НовСвойство.Записать(ИСТИНА);
КонецПроцедуры 

Процедура ОчиститьУстаревшиеПоврежденные() Экспорт
	УстановитьПривилегированныйРежим(ИСТИНА);
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ПоврежденныеПакеты.Пакет КАК Пакет,
	|	ПоврежденныеПакеты.ИдентификаторЗаписи КАК ИдентификаторЗаписи,
	|	ОстаткиПакетовНаСкладах.Объем КАК Объем
	|ИЗ
	|	Константа.Склад КАК КонстантаСклад
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.ПоврежденныеПакеты КАК ПоврежденныеПакеты
	|			ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ОстаткиПакетовНаСкладах КАК ОстаткиПакетовНаСкладах
	|			ПО ПоврежденныеПакеты.Склад = ОстаткиПакетовНаСкладах.Склад
	|				И ПоврежденныеПакеты.Пакет = ОстаткиПакетовНаСкладах.НомерПакета
	|		ПО КонстантаСклад.Значение = ПоврежденныеПакеты.Склад
	|ГДЕ
	|	ОстаткиПакетовНаСкладах.Объем ЕСТЬ NULL";
	Выборка = Запрос.Выполнить().Выбрать();
	УдаляемыеИд = Новый Массив;
	Пока Выборка.Следующий() Цикл
		УдаляемыеИд.Добавить(Выборка.ИдентификаторЗаписи);	
	КонецЦикла;
	Для Каждого м из УдаляемыеИд Цикл
		НЗ = РегистрыСведений.ПоврежденныеПакеты.СоздатьНаборЗаписей();
		НЗ.ОбменДанными.Загрузка = ИСТИНА;
		НЗ.ОбменДанными.Получатели.АвтоЗаполнение = ЛОЖЬ;
		НЗ.ОбменДанными.Получатели.Очистить();
		НЗ.Отбор.ИдентификаторЗаписи.Установить(м);
		НЗ.Записать(ИСТИНА);
	КонецЦикла;
КонецПроцедуры
