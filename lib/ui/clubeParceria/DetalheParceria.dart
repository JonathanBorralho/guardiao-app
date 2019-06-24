import 'package:flutter/material.dart';
import 'package:guardiao_mobile/model/Parceria.dart';
import 'package:guardiao_mobile/model/Sistema.dart';
import 'package:guardiao_mobile/util/Util.dart';
import 'package:guardiao_mobile/ui/clubeParceria/Menu.dart';
import 'package:url_launcher/url_launcher.dart';

class DetalheParceria extends StatefulWidget {

  final Parceria parceria;
  final Sistema sistema;

  DetalheParceria({this.sistema, this.parceria});

  @override
  _DetalheParceriaState createState() => _DetalheParceriaState();
}

class _DetalheParceriaState extends State<DetalheParceria> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      new AppBar(
        centerTitle: true,
          title:Column(children: [
            Text(widget.sistema.nome),
          GestureDetector(
            child: Text('${widget.parceria.nomeParceria}'),
            onTap: () {},
          )
        ]),
        backgroundColor: hexToColorSystem(widget.sistema.cor),
      ),
      drawer: Menu(context, widget.sistema),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.network(widget.parceria.logomarcaUrl, height: 133.0, width: 350.0),
              //Image.asset("assets/icons/info-icon.png", height: 133.0, width: 350.0),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                child: Column(
                  children: <Widget>[
                    new ListTile(
                      leading: SizedBox(height: 35.0, child: Image.asset("assets/icons/info-icon.png")),
                      title: const Text('Ramo de Atividade',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF464646)
                        )
                      ),
                      subtitle: Text(widget.parceria.retornaRamoAtividade()),
                    ),
                    new ListTile(
                      leading: SizedBox(height: 35.0, child: Image.asset("assets/icons/discount.png")),
                      title: const Text('Descontos', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF464646))),
                      subtitle: Text(widget.parceria.descontos),
                    ),
                  ],
                )
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                color: hexToColor("#fbede3"),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Toque nos ícones para contato com a parceria!",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0,
                          ),
                        )
                      )
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: retornaEmail(widget.parceria.email, context),
                                  ),
                                  Expanded(
                                    child: retornaSite(widget.parceria.site),
                                  ),
                                ],
                              ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: retornaFacebook(widget.parceria.facebook),
                                ),
                                Expanded(
                                  child: retornaGoogleMaps(widget.parceria.googleMaps),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: retornaInstagram(widget.parceria.instagram),
                                ),
                                Expanded(
                                  child: retornaTelefone(widget.parceria.telefone1),
                                ),
                              ]
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: retornaWhatsApp(widget.parceria.whatsapp, context),
                                ),
                                Expanded(
                                  child: retornaTelefone(widget.parceria.telefone2),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
        )
      )
    );
  }
}

Widget retornaTelefone(String telefone){
  if(telefone != ''){
    return new ListTile(
      title: const Text('Telefone', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF464646))),
      leading: SizedBox(height: 35.0, child: Image.asset("assets/icons/telephone-logo.png")),
      onTap: () => launch("tel://${telefone}"),
    );
  }else{
    return new ListTile(
      title: const Text('Telefone', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF464646))),
      leading: SizedBox(height: 35.0, child: Image.asset("assets/icons/telephone-logo-disabled.png")),
    );
  }
}

Widget retornaFacebook(String facebook){
  if(facebook != ''){
    return new ListTile(
      title: const Text('Facebook', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF464646))),
      leading: SizedBox(height: 35.0, child: Image.asset("assets/icons/facebook-logo.png") ),
      onTap: () => launch("${facebook}"),
    );
  }else{
    return new ListTile(
      title: const Text('Facebook', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF464646))),
      leading: SizedBox(height: 35.0, child: Image.asset("assets/icons/facebook-logo-disabled.png") ),
    );
  }
}

Widget retornaWhatsApp(String whatsApp, BuildContext context){
  if(whatsApp != ''){
    return new ListTile(
      title: const Text('WhatsApp', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF464646))),
      leading: SizedBox(height: 35.0, child: Image.asset("assets/icons/whatsapp-logo.png")),
      onTap: () => launchWhatsApp(whatsApp, context),
    );
  }else{
    return new ListTile(
      title: const Text('WhatsApp', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF464646))),
      leading: SizedBox(height: 35.0, child: Image.asset("assets/icons/whatsapp-logo-disabled.png")),
    );
  }
}

Widget retornaGoogleMaps(String googleMaps){
  if(googleMaps != ''){
    return new ListTile(
      title: const Text('Localização', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF464646))),
      leading: SizedBox(height: 35.0, child: Image.asset("assets/icons/google-maps-logo.png")),
      onTap: () => launch("${googleMaps}"),
    );
  }else{
    return new ListTile(
      title: const Text('Localização', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF464646))),
      leading: SizedBox(height: 35.0, child: Image.asset("assets/icons/google-maps-logo-disabled.png")),
    );
  }
}

Widget retornaInstagram(String instagram){
  if(instagram != ''){
    return new ListTile(
      title: const Text('Instagram', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF464646))),
      leading: SizedBox(height: 35.0, child: Image.asset("assets/icons/instagram-logo.png")),
      onTap: () => launchInstagram("${instagram}"),
    );
  }else{
    return new ListTile(
      title: const Text('Instagram', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF464646))),
      leading: SizedBox(height: 35.0, child: Image.asset("assets/icons/instagram-logo-disabled.png")),
    );
  }
}

Widget retornaSite(String site){
  if(site != null){
    return new ListTile(
      title: const Text('Site Institucional', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF464646))),
      leading: SizedBox(height: 35.0, child: Image.asset("assets/icons/site-institucional-logo.png")),
      onTap: () => launch("$site"),
    );
  }else{
    return new ListTile(
      title: const Text('Site Institucional', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF464646))),
      leading: SizedBox(height: 35.0, child: Image.asset("assets/icons/site-institucional-logo-disabled.png")),
    );
  }
}

Widget retornaEmail(String email, BuildContext context){
  if(email != null && email != '') {
    return new ListTile(
      title: const Text('E-mail', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF464646))),
      leading: SizedBox(
          height: 35.0,
          child: Image.asset("assets/icons/mail-logo.png")),
      onTap: () => launch("mailto:${email}"),
    );
  }else{
    return new ListTile(
      title: const Text('E-mail', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF464646))),
      leading: SizedBox(height: 35.0, child: Image.asset("assets/icons/mail-logo-disabled.png")),
    );
  }
}
