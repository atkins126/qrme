(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)

{%dependencies.inc}

{---put your dependencies registration here---}

container.add('homeController', THomeControllerFactory.create());
container.add('pngQrCodeGeneratorCtrl', TPngQrCodeGeneratorControllerFactory.create());
container.add('svgQrCodeGeneratorCtrl', TSvgQrCodeGeneratorControllerFactory.create());

container.add('authController', TAuthControllerFactory.create());
container.add('loginController', TLoginControllerFactory.create());
container.add('notLoggedInCtrl', TNotLoggedInControllerFactory.create());

container.add('dashboardController', TDashboardControllerFactory.create());