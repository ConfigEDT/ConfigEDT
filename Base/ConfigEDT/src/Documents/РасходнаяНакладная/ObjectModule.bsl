
Процедура ОбработкаПроведения(Отказ, Режим)
	Движения.ОстаткиТоваров.Записывать = Истина;
	
	ТЗ = Товары.Выгрузить();
	ТЗ.Свернуть("Номенклатура", "Количество");
	
	Для Каждого ТекСтрокаТовары Из ТЗ Цикл
		Движение = Движения.ОстаткиТоваров.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
		Движение.Период = Дата;
		Движение.Номенклатура = ТекСтрокаТовары.Номенклатура;
		Движение.Количество = ТекСтрокаТовары.Количество;
	КонецЦикла;

	Движения.Записать();
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ОстаткиТоваровОстатки.Номенклатура,
		|	ОстаткиТоваровОстатки.КоличествоОстаток
		|ИЗ
		|	РегистрНакопления.ОстаткиТоваров.Остатки(&МоментВремени) КАК ОстаткиТоваровОстатки
		|ГДЕ
		|	ОстаткиТоваровОстатки.КоличествоОстаток < 0";
	
	Запрос.УстановитьПараметр("МоментВремени", МоментВремени());
	РезультатЗапроса = Запрос.Выполнить();
	
	Если Не РезультатЗапроса.Пустой() Тогда
		Отказ = Истина;	
		
		Выборка = РезультатЗапроса.Выбрать();
		Пока Выборка.Следующий() Цикл
			
		КонецЦикла;
	КонецЕсли;

КонецПроцедуры
