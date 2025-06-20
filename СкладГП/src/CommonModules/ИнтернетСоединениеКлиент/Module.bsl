#Область СоединениеСИнтернет
Процедура ОбработкаИзмененияКачестваСоединения(ДопПар) Экспорт
	#Если МобильноеПриложениеКлиент или МобильныйКлиент Тогда
		ТипСоединения = ИнформацияОбИнтернетСоединении.ПолучитьТипСоединения();
		Если ТипСоединения = ТипИнтернетСоединения.НетСоединения Тогда 
			ЕстьСвязь = ЛОЖЬ;
			Оповестить("ИзменениеКачестваСвязи", ЕстьСвязь);
		Иначе
			ПроверитьСвязь_Подключаемый();
		КонецЕсли
	#КонецЕсли
КонецПроцедуры

Процедура ПодключитьОбработчикИзмененияКачестваСоединения() Экспорт
	#Если МобильноеПриложениеКлиент или МобильныйКлиент Тогда
		ОбработкаИзмененияКачестваСоединения = Новый ОписаниеОповещения("ОбработкаИзмененияКачестваСоединения", ИнтернетСоединениеКлиент);
		ИнформацияОбИнтернетСоединении.ПодключитьОбработчикИзмененияИнтернетСоединения(ОбработкаИзмененияКачестваСоединения);
	#Иначе
		ПроверитьСвязь_Подключаемый();
	#КонецЕсли
КонецПроцедуры

Процедура ПроверитьСвязь_Подключаемый(СброситьСостояние = ЛОЖЬ) Экспорт 
	Если СброситьСостояние Тогда
		ЕстьСвязь = ЛОЖЬ;
	КонецЕсли;
	ПроверитьСвязь_ПодключаемыйАсинх(СброситьСостояние)	
КонецПроцедуры

Асинх Процедура ПроверитьСвязь_ПодключаемыйАсинх(СброситьСостояние = ЛОЖЬ) 
	Если СброситьСостояние Тогда
		БылаСвязь = ЛОЖЬ;
	Иначе
		БылаСвязь = ?(ЕстьСвязь = Неопределено, ЛОЖЬ, ЕстьСвязь);	
	КонецЕсли;
	ЕстьСвязь = Ждать http_Клиент.ЕстьСвязь(СброситьСостояние);
	Если Не БылаСвязь = ЕстьСвязь или СброситьСостояние Тогда
		Оповестить("ИзменениеКачестваСвязи", ЕстьСвязь);
	КонецЕсли;
КонецПроцедуры



#КонецОбласти