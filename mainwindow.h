#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QSqlDatabase>
#include <QtSql>

namespace Ui {
	class MainWindow;
}

class MainWindow : public QMainWindow
{
		Q_OBJECT

	public:
		explicit MainWindow(QWidget *parent = 0);
		~MainWindow();

	private slots:
		void on_actionQuit_triggered();

		void on_btn_wczytajA_clicked();

		void on_btn_wczytajB_clicked();

		void on_btn_wczytajC_clicked();

		void on_btn_clr_clicked();

		void on_btn_testA_clicked();

		void on_btn_testB_clicked();

		void on_btn_testC_clicked();

		void on_btn_testALL_clicked();

		void on_btn_test_connection_clicked();

	private:
		Ui::MainWindow *ui;
		QSqlDatabase db;

		QString wczytajPlik(QString nazwa);
		QString polacz();
};

#endif // MAINWINDOW_H
