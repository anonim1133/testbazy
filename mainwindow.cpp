#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
	QMainWindow(parent),
	ui(new Ui::MainWindow)
{
	ui->setupUi(this);

	ui->toolBox->setCurrentIndex(0);

	//Wczytać tekst z pliku A
	//Wrzucić do txt_A
	ui->txt_A->appendPlainText(wczytajPlik("A.sql"));

	//Wczytać tekst z pliku B
	//Wrzucić do txt_B
	ui->txt_B->appendPlainText(wczytajPlik("B.sql"));

	//Wczytać tekst z pliku C
	//Wrzucić do txt_C
	ui->txt_C->appendPlainText(wczytajPlik("C.sql"));
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
