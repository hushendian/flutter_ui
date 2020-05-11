class provinceBean {
  String province;
  List<Citys> citys;

  provinceBean({this.province, this.citys});

  provinceBean.fromJson(Map<String, dynamic> json) {
    province = json['province'];
    if (json['citys'] != null) {
      citys = new List<Citys>();
      json['citys'].forEach((v) {
        citys.add(new Citys.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province'] = this.province;
    if (this.citys != null) {
      data['citys'] = this.citys.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Citys {
  String cityName;
  List<String> areas;

  Citys({this.cityName, this.areas});

  Citys.fromJson(Map<String, dynamic> json) {
    cityName = json['cityName'];
    areas = new List<String>();
    json['areas'].forEach((v) {
      areas.add(v);
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityName'] = this.cityName;
    data['areas'] = this.areas;
    return data;
  }
}