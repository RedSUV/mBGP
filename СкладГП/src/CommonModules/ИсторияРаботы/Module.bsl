Процедура мЗаписьИстории(ИмяСобытия, Примечание = "", Ошибка = ЛОЖЬ) Экспорт
	УстановитьПривилегированныйРежим(ИСТИНА);
	
	МЗ = РегистрыСведений.ИсторияРаботы.СоздатьМенеджерЗаписи();
	МЗ.ИмяСобытия = ИмяСобытия;
	МЗ.ДатаСобытия = ТекущаяДата();
	МЗ.Ошибка = Ошибка;
	МЗ.Примечание = Примечание;
	МЗ.Записать(ИСТИНА);
КонецПроцедуры