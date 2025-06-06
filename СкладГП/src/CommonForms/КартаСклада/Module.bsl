Функция ШаблонКарты()
	Возврат
	"<!DOCTYPE html>
	|<html>
	|<head>
	|<meta charset=""UTF-8"">
	|<meta name=""viewport"" content=""width=device-width, initial-scale=1, minimum-scale=1"">
	|<script src=""https://api-maps.yandex.ru/v3/?apikey=e33b8bf4-622d-4bc0-bcb5-3888ee040b99&lang=en_EN"" type=""text/javascript""></script>
	|<script>
	|	const LOCATION = { center: [36.382939, 61.003705], zoom: 13 };
	|	window.map = null;
	|
	|	main();
	|	async function main() {
	|		await ymaps3.ready;
	|		const {
	|			YMap,
	|			YMapDefaultSchemeLayer,
	|			YMapControls
	|		} = ymaps3;
	|	
	|		const {YMapZoomControl} = await ymaps3.import('@yandex/ymaps3-controls@0.0.1');
	|	
	|		map = new YMap(document.getElementById('app'), {location: LOCATION}, [
	|			new YMapDefaultSchemeLayer(),
	|			new YMapControls({position: 'right'}, [
	|				new YMapZoomControl({})
	|			]),
	|		]);
	|	}
	|   ymaps3.ready.then(() => {
    |       manageMap.onclick = () => {
    |          manageMap.innerHTML = !map ? 'Delete map' : 'Create map';
    |            if (map) {
    |                map.destroy();
    |                map = null;
    |            } else {
    |                main();
    |            }
    |        };
    |    });
	|</script>
	|		
	|<style>
	|	html,
	|	body,
	|	#app {
	|		width: 100%;
	|		height: 100%;
	|		margin: 0;
	|		padding: 0;
	|		
	|		font-family: 'Yandex Sans Text', Arial, Helvetica, sans-serif;
	|	}
	|		
	|	.toolbar {
	|		position: absolute;
	|		z-index: 1000;
	|		top: 0;
	|		left: 0;
	|		
	|		display: flex;
	|		align-items: center;
	|		
	|		padding: 16px;
	|	}
	|</style>
	|</head>
	|<body>
	|	<div class=""toolbar""><button type=""button"" id=""manageMap"">Delete map</button></div>
	|	<div id=""app""></div>
	|</body>
	|</html>";
КонецФункции 

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Карта =  ШаблонКарты();
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Карта =  ШаблонКарты();
КонецПроцедуры

&НаКлиенте
Процедура КартаДокументСформирован(Элемент)
КонецПроцедуры

&НаКлиенте
Процедура КартаПриНажатии(Элемент, ДанныеСобытия, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
КонецПроцедуры
