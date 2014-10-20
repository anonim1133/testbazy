#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QFileDialog>
#include <QMessageBox>


MainWindow::MainWindow(QWidget *parent) :	QMainWindow(parent),	ui(new Ui::MainWindow){
	ui->setupUi(this);

	db = QSqlDatabase::addDatabase("QPSQL");

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

void MainWindow::on_btn_clr_clicked()
{
	ui->txt_wynik->setText("");
}

QString MainWindow::polacz(){
	if(db.isOpen()) db.close();

	db.setHostName(ui->txt_server->text());
	db.setPort(ui->txt_port->text().toInt());
	db.setDatabaseName(ui->txt_dbname->text());
	db.setUserName(ui->txt_user->text());
	db.setPassword(ui->txt_pass->text());

	db.open();

	if(db.isOpen()) return "true";
	else return db.lastError().text();
}

void MainWindow::on_btn_test_connection_clicked()
{
	QString wynik = polacz();

	QMessageBox msgBox;
	if(wynik == "true"){
		msgBox.setText("Wynik pozytywny");
		msgBox.setInformativeText("Udało się nawiązać połączenie z bazą danych.");
	}else{
		msgBox.setText("Błąd!");
		msgBox.setInformativeText(wynik);
		msgBox.setFixedWidth(500);
	}

	msgBox.exec();
}


void MainWindow::on_btn_testA_clicked()
{



	ui->txt_wynik->setText("TEST A" + db.lastError().text());
}

void MainWindow::on_btn_testB_clicked()
{
	ui->txt_wynik->setText("TEST B");
}

void MainWindow::on_btn_testC_clicked()
{
	ui->txt_wynik->setText("TEST C");
}

void MainWindow::on_btn_testALL_clicked()
{
	ui->txt_wynik->setText("TEST ALL");
}