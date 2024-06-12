import 'package:flutter/material.dart';
import  'pages/home.dart';
import  'pages/loading.dart';
import  'pages/login.dart';
import  'pages/signup.dart';
import  'pages/agenda.dart';
import  'pages/agendaitempage.dart';
import  'pages/addagendaitem.dart';
import  'pages/profile.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/home',
  routes: {
    '/': (context) => Loading(),
    '/login': (context) => Login(),
    '/sign_up': (context) => SignUp(),
    '/home': (context) => Home(),
    '/home/profile': (context) => Profile(),
    '/home/agenda': (context) => Agenda(),
    '/home/agenda/item': (context) => AgendaItemPage(),
    '/home/agenda/add': (context) => AddAgendaItemPage(),
  }
));