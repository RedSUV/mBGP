Процедура ПроверитьНастроитьПланОбмена() Экспорт
	МобильноеПриложениеСкладПУ.ПроверитьНастроитьПланОбмена();
КонецПроцедуры

Функция ПолучитьАдресДляПинг(Знач БазаПУ = Неопределено) Экспорт
	Если БазаПУ = Неопределено Тогда
		БазаПУ = Константы.АдресПУ.Получить();
	КонецЕсли;
	
	Возврат  БазаПУ.АдресДляPing
КонецФункции

