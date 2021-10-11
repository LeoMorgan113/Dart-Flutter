import 'dart:io';

const author = "Koriavikova Valeriia, TI-81";

class deviceProfile{
  var profileName = 'default';
  var devices = []; //List

  // constructor
  deviceProfile(this.profileName){
    this.profileName = name;
  }
  set setDevices(var devArr){ //setter
    for(var item in devArr) {
      devices.add(item); //add to List
    }
  }
  String get name => profileName; //getter

}

class Device{
  var name, type;
  var telemetry; // Map
  var firmware;
  final _transport = 'default'; // private field

  Device(this.name, this.type, this.telemetry);  // constructor



  Device.origin(){ // named constructor
    name = 'default';
    type = 'default';
    telemetry = {};
  }

  printInfo(){
    print('Name: $name\nType: $Type\nTelemetry:');
    for(var item in telemetry.entries){
      print("${item.key} = ${item.value}");
    }
  }
  set setFirmware(var version) => firmware = version; //setter

  String? get getFirmware => firmware; //getter

  String get transport => _transport; //getter

  printPrivate(){
    print('Transport: $_transport');
  }
}

class Thermostat extends Device{ //
  var version = 3;
  var attributes = <String>{}; // Set
  @override
  final _transport = 'MQTT'; // private field

  //default and optional parameter
  // a non-default superclass constructor
  Thermostat(var Name, {var Type='Thermostat', var Telemetry, var Attributes}) : super(Name, Type, Telemetry);

  String get transport => _transport;// getter

  printPrivate(){
    print('Transport: $_transport');
  }

  set vThermostat(var v) => version ??= v;// setter && syntax sugar
  num get getVersionThermostat => version;// getter
}

mixin Account{
  void account(var whose){
    print('\n$whose account');
  }
}

class User with Account{
  var name, email, country;
  // var role = 'default user';

  User.info(var Name, var Email, var Country){
    name = Name;
    email = Email;
    country = Country;
  }
  void printUser({var role='Default user'}){
    print('Name: $name | Email: $email | Country: $country | Role: $role');
  }
  // get getRole => role;
}

class Tenant extends User with Account{
  var role = 'Tenant';

  Tenant.info(Name, Email, Country) : super.info(Name, Email, Country);

  void printUser({var role='Default user'}){
    super.printUser();
    print('Role: $role');
  }
  get getRole => role;
}

abstract class Widget{

  Widget._();

  factory Widget(var int){
    switch(int){
      case 1:
        return BarChart();
      case 2:
        return LineChart();
      case 3:
        return Table();
      default:
        return BarChart();
    }
  }

  void drawWidget(){}
}

class BarChart extends Widget{
  BarChart() : super._();

  @override
  void drawWidget(){
    print('\nDraw Bar Chart Widget');
  }
}

class LineChart extends Widget{
  LineChart(): super._();

  @override
  void drawWidget(){
    print('\nDraw Line Chart Widget');
  }
}

class Table extends Widget{
  Table(): super._();

  @override
  void drawWidget(){
    print('\nDraw Table Widget');
  }


}

main(){
  print('Lab # 1\nAuthor: $author\n');

  var role = 'Tenant';
  var TenantAdmin = User.info('Robert', 'robert3@gmail.com', 'Spain');
  TenantAdmin.account(role);
  TenantAdmin.printUser(role: role);

  var defaultProfile = deviceProfile("Default Profile");
  var deviceProfileName = defaultProfile.profileName;
  print("Device profile: $deviceProfileName");

  var Sensor = Device('SN-091', 'Sensor', {'Air Flow': 21});
  Sensor.printInfo();
  print('Please input firmware of your device: ');
  Sensor.firmware = stdin.readLineSync();
  assert(Sensor.firmware == '3.3');
  var getFirmware = Sensor.firmware;
  print('Firmware: $getFirmware');
  Sensor.printPrivate();
  var Thermostat_1 = Thermostat('DN-5612A', Telemetry: {"Temperature": 21});
  Thermostat_1.printPrivate();
  print("Set Thermostat version: ");
  Thermostat_1.vThermostat = stdin.readLineSync();
  print(Thermostat_1.getVersionThermostat);

  var Thermostat_2 = Thermostat('DM-123EW', Telemetry: {"Temperature": 45}, Attributes: {'offline', });

  defaultProfile.setDevices = [Sensor.name, Thermostat_1.name, Thermostat_2.name];
  print("Devices with the default profile: ", );
  print(defaultProfile.devices);

  var widgetForData = new Widget(3);
  widgetForData.drawWidget();

  Function countAverageData = (var data) {
    num sum = 0;
    for(var d in data){
      sum += d;
    }
    return sum/data.length;
  };
  Function multiplyData = (var data){
    return (num multiplier) => data * multiplier;
  };

  num average = countAverageData([56, 45, 23, 27]);
  print("Average of telemetry: $average");
  var multiplyAverage = multiplyData(average);
  print("Doubled average: " + multiplyAverage(2).toString());
}