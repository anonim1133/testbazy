#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QFileDialog>

MainWindow::MainWindow(QWidget *parent) :
	QMainWindow(parent),
	ui(new Ui::MainWindow)
{
	ui->setupUi(this);

	ui->toolBox->setCurrentIndex(0);

	//Wczytać tekst z pliku A
	//Wrzucić do txt_A
	ui->txt_A->setPlainText(wczytajPlik("A.sql"));

	//Wczytać tekst z pliku B
	//Wrzucić do txt_B
	ui->txt_B->setPlainText(wczytajPlik("B.sql"));

	//Wczytać tekst z pliku C
	//Wrzucić do txt_C
	ui->txt_C->setPlainText(wczytajPlik("C.sql"));
}

MainWindow::~MainWindow()
{
	delete ui;
}

void MainWindow::on_actionQuit_triggered()
{
	close();
}

QString MainWindow::wczytajPlik(QString nazwa){
	QString txt = "";

	QFile file(nazwa);
	if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
		return "";

	while (!file.atEnd())
		txt.append(file.readLine());

	return txt;
}

void MainWindow::on_btn_wczytajA_clicked(){
	QString nazwa = QFileDialog::getOpenFileName(this, tr("Open File"), "",
												 tr("Files (*.*)"));

	QString txt = "";
	QFile file(nazwa);
	if (file.open(QIODevice::ReadOnly | QIODevice::Text)){
		while (!file.atEnd())
			txt.append(file.readLine());

		ui->txt_A->setPlainText(txt);
	}
}

void MainWindow::on_btn_wczytajB_clicked()
{
	QString nazwa = QFileDialog::getOpenFileName(this, tr("Open File"), "",
												 tr("Files (*.*)"));
	QString txt = "";
	QFile file(nazwa);
	if(file.open(QIODevice::ReadOnly | QIODevice::Text)){
		while (!file.atEnd())
			txt.append(file.readLine());

		ui->txt_B->setPlainText(txt);
	}
}

void MainWindow::on_btn_wczytajC_clicked()
{
	QString nazwa = QFileDialog::getOpenFileName(this, tr("Open File"), "",
												 tr("Files (*.*)"));

	QString txt = "";
	QFile file(nazwa);
	if(file.open(QIODevice::ReadOnly | QIODevice::Text)){
		while (!file.atEnd())
			txt.append(file.readLine());

		ui->txt_C->setPlainText(txt);
	}
}
