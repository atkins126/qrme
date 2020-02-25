(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)

{%dependencies.inc}

{---put your dependencies registration here---}

container.add('breadcrumbTemplate', TBreadcrumbViewPartialFactory.create());
container.add('footerTemplate', TFooterViewPartialFactory.create());
container.add('leftMenuTemplate', TLeftMenuViewPartialFactory.create());
container.add('topBarTemplate', TTopBarViewPartialFactory.create());
container.add('topCssTemplate', TTopCssViewPartialFactory.create());
container.add('bottomJsTemplate', TBottomJsViewPartialFactory.create());
container.add('mainTemplate', TMainViewPartialFactory.create());
container.add('fullWidthTemplate', TFullViewPartialFactory.create());

container.add('loginView', TLoginViewFactory.create());
