
Процедура УстановкаПараметровСеанса(ТребуемыеПараметры)
	Если НЕ ТребуемыеПараметры = Неопределено Тогда
		Для Каждого ИмяПС из ТребуемыеПараметры Цикл
			Если ИмяПС = "ВидИнтерфейсаНочь" Тогда
				ПараметрыСеанса.ВидИнтерфейсаНочь = Константы.ТемнаяТема.Получить();
			ИначеЕсли ИмяПС = "ИдентификаторУстройства" Тогда
				ПараметрыСеанса.ИдентификаторУстройства = ОбщегоНазначенияВызовСервераПовтИсп.ДанныеУстройства();
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;	
КонецПроцедуры
