#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

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

	private:
		Ui::MainWindow *ui;

		QString wczytajPlik(QString nazwa);
};

#endif // MAINWINDOW_H
