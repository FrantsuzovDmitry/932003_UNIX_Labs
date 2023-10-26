#include <QObject>
#include <QApplication>
#include <QPushButton>
#include <QLineEdit>
#include <QVBoxLayout>
#include <QWidget>

int main(int argc, char* argv[]) {

    QApplication app(argc, argv);                       // Initialization

    QWidget window;                                     // Some kind of Form
    window.resize(400, 200);

    QVBoxLayout* layout = new QVBoxLayout(&window);     // Vertical layout on window

    QLineEdit* lineEdit = new QLineEdit(&window);       // Edit field
    lineEdit->setFixedHeight(35);
    layout->addWidget(lineEdit);

    QPushButton* sadButton = new QPushButton("Sad button :(", &window);
    sadButton->setFixedHeight(50);
    layout->addWidget(sadButton);

    QPushButton* exitButton = new QPushButton("Exit", &window);
    exitButton->setFixedHeight(50);
    layout->addWidget(exitButton);

    // Exit to click on "Exit"
    QObject::connect(exitButton, SIGNAL(clicked()), &app, SLOT(quit()));

    // Behaviour to click on "Sad button"
    bool isSad = true;
    QObject::connect(sadButton, &QPushButton::clicked, [&isSad, sadButton, lineEdit]() {
        if (isSad)
        {
            sadButton->setText("Smiling button :)");
            isSad = false;
        }
        else
        {
            sadButton->setText("Happy button :D");
        }

        lineEdit->setText("This button doing nothing, but it glad you clicked on it");
        });

    window.show();
    return app.exec();
}
