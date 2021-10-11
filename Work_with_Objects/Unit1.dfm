object Form1: TForm1
  Left = 265
  Top = 130
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Work with Objects'
  ClientHeight = 122
  ClientWidth = 314
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 120
  TextHeight = 16
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 145
    Height = 25
    Caption = 'Simulate creation'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 160
    Top = 8
    Width = 145
    Height = 25
    Caption = 'Classic creation'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 40
    Width = 145
    Height = 25
    Caption = 'Simulate destruction'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 160
    Top = 40
    Width = 145
    Height = 25
    Caption = 'Classic destruction'
    TabOrder = 3
    OnClick = Button4Click
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 72
    Width = 267
    Height = 17
    Caption = 'Raise error in constructor'
    TabOrder = 4
  end
  object CheckBox2: TCheckBox
    Left = 8
    Top = 96
    Width = 267
    Height = 17
    Caption = 'Raise error in destructor'
    TabOrder = 5
  end
end
