#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QFileDialog>
#include <QMessageBox>
#include <QString>


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
		ui->statusBar->showMessage("Połączenie działa prawidłowo");
	}else{
		msgBox.setText("Błąd!");
		msgBox.setInformativeText(wynik);
		ui->statusBar->showMessage("Problem z połączeniem");
	}

	msgBox.exec();
}


void MainWindow::on_btn_testA_clicked()
{
	polacz();

	QString plainTextEditContents = ui->txt_A->toPlainText();
	QStringList lines = plainTextEditContents.split("\n");

	QString q_txt;
	QTime myTimer;

	ui->txt_wynik->append("Start A");

	int i = 0;
	foreach (q_txt, lines) {
		i++;

		myTimer.start();

		QSqlQuery q = QSqlQuery(q_txt);
		q.exec();

		ui->txt_wynik->append("Zapytanie zajęło " + myTimer.fromMSecsSinceStartOfDay(myTimer.elapsed()).toString("hh:mm:ss.zzz"));
	}


	ui->txt_wynik->append("Koniec "+db.lastError().text());
}

void MainWindow::on_btn_testB_clicked()
{
	polacz();

	QString plainTextEditContents = ui->txt_B->toPlainText();
	QStringList lines = plainTextEditContents.split("\n");

	QString q_txt;
	QTime myTimer;

	ui->txt_wynik->append("Start B");

	int i = 0;
	foreach (q_txt, lines) {
		i++;

		myTimer.start();

		QSqlQuery q = QSqlQuery(q_txt);
		q.exec();

		ui->txt_wynik->append("Zapytanie zajęło " + myTimer.fromMSecsSinceStartOfDay(myTimer.elapsed()).toString("hh:mm:ss.zzz"));
	}


	ui->txt_wynik->append("Koniec "+db.lastError().text());
}

void MainWindow::on_btn_testC_clicked()
{
	polacz();

	QString plainTextEditContents = ui->txt_B->toPlainText();
	QStringList lines = plainTextEditContents.split("\n");

	QString q_txt;
	QTime myTimer;

	ui->txt_wynik->append("Start B");

	int i = 0;
	foreach (q_txt, lines) {
		i++;

		myTimer.start();

		QSqlQuery q = QSqlQuery(q_txt);
		q.exec();

		ui->txt_wynik->append("Zapytanie zajęło " + myTimer.fromMSecsSinceStartOfDay(myTimer.elapsed()).toString("hh:mm:ss.zzz"));
	}


	ui->txt_wynik->append("Koniec "+db.lastError().text());
}

void MainWindow::on_btn_testALL_clicked()
{
	on_btn_testA_clicked();
	on_btn_testB_clicked();
	on_btn_testC_clicked();
}