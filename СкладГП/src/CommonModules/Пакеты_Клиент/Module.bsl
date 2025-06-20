Процедура НачатьСканирование1с(ОбработчикРезультатаСканирования, мТипШтрихКода = НЕОПРЕДЕЛЕНО) Экспорт
	#Если МобильноеПриложениеКлиент или МобильныйКлиент  Тогда
		Если мТипШтрихКода = НЕОПРЕДЕЛЕНО Тогда
			мТипШтрихКода = ?(ОбщегоНазначенияВызовСервераПовтИсп.ШтрихКод2D(), ТипШтрихКода.Двухмерный, ТипШтрихКода.Линейный);	
		КонецЕсли;
		
		 Если НЕ СредстваМультимедиа.ПоддерживаетсяСканированиеШтрихКодов() Тогда
    		ВызватьИсключение НСтр("ru='Сканирование штрихкодов не поддерживается';en='Barcode scanning is not supported'");
			Возврат;
  		КонецЕсли;
  		СредстваМультимедиа.ПоказатьСканированиеШтрихКодов(НСтр("ru='Наведите камеру на штрихкод';en='Aim the camera at an barcode'"), ОбработчикРезультатаСканирования, , мТипШтрихКода);
	#конецесли

КонецПроцедуры

Процедура НачатьСканированиеBarcode(ОбработчикСканирования) Экспорт
	#Если МобильноеПриложениеКлиент или МобильныйКлиент Тогда
		МобПрил = Новый ЗапускПриложенияМобильногоУстройства("com.xiaomi.scanner.app.ScanActivity");
		//МобПрил = Новый ЗапускПриложенияМобильногоУстройства();
		//МобПрил.Действие="com.cognex.mxconnect.action";
		МобПрил.Запустить(Истина);

        Для Каждого ПарСтр Из МобПрил.ДополнительныеДанные Цикл

			Если СокрЛП(ПарСтр.Ключ) = "SCAN_RESULT" Тогда
				ВыполнитьОбработкуОповещения(ОбработчикСканирования, ПарСтр.Ключ);
            КонецЕсли;
        КонецЦикла;

    #КонецЕсли	
КонецПроцедуры

Процедура ДобавитьУведомление(Заголовок = "",Текст = "",Данные = "",ДатаПоявленияUTC = 0,ИнтервалПовтора = 0,ЗвукОповещение = Неопределено) Экспорт
	Уведомление = Новый ДоставляемоеУведомление;
	Уведомление.Заголовок = Заголовок;
	Уведомление.Текст = Текст;
	Уведомление.Данные = Данные;
	Уведомление.ИнтервалПовтора = ИнтервалПовтора;
	Если ДатаПоявленияUTC = 0 Тогда
		ДатаПоявленияUTC = '00010101';
	КонецЕсли;
	Уведомление.ДатаПоявленияУниверсальноеВремя = ДатаПоявленияUTC;
	Если ЗвукОповещение = Неопределено Тогда
		ЗвукОповещение = ЗвуковоеОповещение.ПоУмолчанию;
	КонецЕсли;
	Уведомление.ЗвуковоеОповещение = ЗвукОповещение;
	
	#Если МобильныйКлиент или МобильноеПриложениеКлиент Тогда
		ДоставляемыеУведомления.ДобавитьЛокальноеУведомление(Уведомление);
	#КонецЕсли
КонецПроцедуры