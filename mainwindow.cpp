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

	//Wczytać tekst z pliku B
	//Wrzucić do txt_B

	//Wczytać tekst z pliku C
	//Wrzucić do txt_C
}

MainWindow::~MainWindow()
{
	delete ui;
}

void MainWindow::on_actionQuit_triggered()
{
	close();
}
