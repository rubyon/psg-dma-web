import consumer from "channels/consumer"

let mapData = "";

let animation_tile = 0;

function getApi() {
  const xhr = new XMLHttpRequest();
  const page = document.getElementById('page');
  xhr.onreadystatechange = function() {
    if (xhr.readyState === XMLHttpRequest.DONE) {
      if (xhr.status === 200) {
        // 요청이 성공하면 데이터를 처리
        mapData = JSON.parse(xhr.responseText);
      } else {
        // 요청이 실패한 경우 에러 처리
        console.error('Error: ' + xhr.status);
      }
    }
  };
  xhr.open('GET', `/api/get_map/${page.innerText}`, true);
  xhr.send();
}
getApi();

let tilesetWidth;
let tilesetHeight;
let layerHeight;
let columns;
let tileColumns;

// XMLHttpRequest를 사용하여 파일 불러오기
var xhr = new XMLHttpRequest();
xhr.open('GET', '/psg-dma-sample/psg-dma.tmx', true);
xhr.onreadystatechange = function() {
  if (xhr.readyState === 4 && xhr.status === 200) {
    var xmlString = xhr.responseText;
    // XML 파싱
    var parser = new DOMParser();
    var xmlDoc = parser.parseFromString(xmlString, 'text/xml');
    // 필요한 속성 값 가져오기
    tilesetWidth = xmlDoc.getElementsByTagName('tileset')[0].getAttribute('tilewidth');
    tilesetHeight = xmlDoc.getElementsByTagName('tileset')[0].getAttribute('tileheight');
    layerHeight = xmlDoc.getElementsByTagName('map')[0].getAttribute('height');
    columns = xmlDoc.getElementsByTagName('map')[0].getAttribute('width');
    tileColumns = xmlDoc.getElementsByTagName('tileset')[0].getAttribute('columns');
  }
};
xhr.send();

function calculatePercentage(value, min, max) {
  if (value < min || value > max) {
    console.log("Value out of range"); // 범위를 벗어나는 경우 에러 처리
    return null;
  }

  const range = max - min;
  const percentage = ((value - min) / range) * 100;

  return Math.floor(percentage);
}

function calculateBackgroundPosition(tileId) {
  var tileSize = tilesetWidth; // 타일 크기 (가로와 세로가 동일하다고 가정)
  var tilesPerRow = tileColumns; // 가로에 있는 타일의 수 (TSX 파일에서 선언한 가로 타일의 수와 동일하다고 가정)
  var x = (tileId % tilesPerRow) * tileSize;
  var y = Math.floor(tileId / tilesPerRow) * tileSize;
  return "-" + x + "px " + "-" + y + "px";
}

function barGaugeUpdate( div, tileId, width, height, value, offSetX, offSetY, foregroundColor, backgroundColor ) {
  const container = document.getElementById(`analog-${tileId}`);
  const customDiv = document.getElementById(div);

  if (!customDiv) {
    const customDiv = document.createElement('div');
    customDiv.id = div;
    customDiv.style.width =  width + 'px';
    customDiv.style.height = height + 'px';
    customDiv.style.top =  (offSetY ) + 'px';
    customDiv.style.left = offSetX + 'px';

    customDiv.style.position = 'relative';
    customDiv.style.backgroundColor = backgroundColor;
    container.appendChild(customDiv);

    const afterElement = document.createElement('div');
    afterElement.id = `${div}-after`;
    afterElement.style.display = 'block';
    afterElement.style.position = 'absolute';
    afterElement.style.bottom = 0;
    afterElement.style.backgroundColor = foregroundColor;
    afterElement.style.width = "100%";
    customDiv.appendChild(afterElement);
  }
  var afterElement = document.getElementById(`${div}-after`);
  afterElement.style.height = `${value}%`;
}

function analogUpdate( div, tileId, fontSize, color, value, offSetX, offSetY, align, scale = 1, link ) {

  if ( link === null ) {
    link = "#";
  }

  const parentDiv = document.getElementById(`analog-${tileId}`);
  let analogDiv = document.getElementById(div);

// Check if div element exists
  if (!analogDiv) {
    analogDiv = document.createElement('div');
    analogDiv.id = div;
    parentDiv.appendChild(analogDiv);
  }

  const anchorTag = document.createElement('a');
  anchorTag.href = link; // 원하는 링크 URL을 입력합니다.
  anchorTag.appendChild(document.createTextNode(value));

  anchorTag.setAttribute('data-turbo', 'false'); // turbo: false를 설정합니다.

  analogDiv.style.position = 'relative';
  analogDiv.style.width = (tilesetWidth * scale) + 'px';
  analogDiv.style.top = offSetY + 'px';
  analogDiv.style.left = offSetX + 'px';
  analogDiv.style.textAlign = align;
  analogDiv.style.fontSize = fontSize + 'pt';
  analogDiv.style.color = color;
  analogDiv.style.fontWeight = 'bold';

  analogDiv.innerHTML = ''; // analogDiv 안의 내용// 을 비웁니다.
  analogDiv.appendChild(anchorTag); // <a> 태그를 analogDiv 안에 추가합니다.
}

consumer.subscriptions.create("ModbusChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to the modbus channel");

    // Add Title Text
    let titleIndex = 0
    mapData["titles"].forEach( item => {
      analogUpdate( `title_${titleIndex}`, item.tile_id, item.font_size, item.font_color,item.text, item.offset_x, item.offset_y, item.align, item.scale, item.link);
      titleIndex += 1;
    });
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log(data);

    // Digital value
    if (data.action === "digital") {

      console.log(`animation_tile: ${animation_tile}`);
      const modbusArray = data.value.split("");
      const layer = "digital";

      mapData["digitals"].forEach( item => {

        const valveId = layer + '-' + item["tile_id"];
        const valveDiv = document.getElementById(valveId);
        let valve_on = "";

        if (item["on_2"] === "") {
          valve_on = calculateBackgroundPosition(item["on_1"]);
        } else {
          valve_on = calculateBackgroundPosition(item[`on_${animation_tile + 1}`]);
        }
        const valve_off = calculateBackgroundPosition(item["off"]);

        if ( modbusArray[item["modbus_bit"]] === '0' ) {
          valveDiv.style.backgroundPosition = valve_off;
        } else {
          valveDiv.style.backgroundPosition = valve_on;
        }

      });
      animation_tile += 1;
      if (animation_tile === 3) {
        animation_tile = 0;
      }
    }
    // Analog value
    if (data.action === "analog") {

      let gaugesIndex = 0
      mapData["gauges"].forEach( item => {
        barGaugeUpdate(`gauge_${gaugesIndex}`, item.tile_id, item.width, item.height, calculatePercentage(data.value[item.modbus_index], item.min, item.max), item.offset_x, item.offset_y, item.foreground_color, item.background_color);
        gaugesIndex += 1;
      });
      
      let analogsIndex = 0
      mapData["analogs"].forEach( item => {
        analogUpdate( `analog_${analogsIndex}`, item.tile_id, item.font_size, item.font_color, data.value[item.modbus_index], item.offset_x, item.offset_y, item.align, item.scale);
        analogsIndex += 1;
      });

    }
  }
});
