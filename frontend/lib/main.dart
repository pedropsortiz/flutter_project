import 'package:flutter/material.dart';
import  'pages/home.dart';
import  'pages/loading.dart';
import  'pages/login.dart';
import  'pages/signup.dart';
import  'pages/agenda.dart';
import  'pages/agendaitempage.dart';
import  'pages/addagendaitem.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
    '/': (context) => Loading(),
    '/home': (context) => Home(),
    '/login': (context) => Login(),
    '/sign_up': (context) => SignUp(),
    '/home/agenda': (context) => Agenda(),
    '/home/agenda/item': (context) => AgendaItemPage(),
    '/home/agenda/add': (context) => AddAgendaItemPage(),
  }
));