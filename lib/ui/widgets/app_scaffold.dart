import 'dart:async';
import 'dart:io';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../util/route/app_router.dart';
import '../../util/ui_util/app_text_styles.dart';
import '../../util/ui_util/color/color_manager.dart';

class AppScaffold extends StatefulWidget {
  final Stream<bool>? loadingStream;
  final Color? appBarColor;
  final Color? backButtonColor;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final String? appBarTitle;
  final bool hasBackButton;
  final bool canPop;
  final bool hasAppBar;
  final bool hasBottomSafeArea;
  final bool centerTitle;
  final bool resizeToAvoidBottomInset;
  final bool useAppLoader;
  final List<Widget>? trailing;
  final Widget? leading;
  final Widget? body;
  final Widget? scrollChild;
  final AppBar? appBar;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final CrossAxisAlignment crossAxisAlignment;
  final Function()? backButtonAction;

  const AppScaffold({
    this.loadingStream,
    this.appBarColor,
    this.backButtonColor,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.hasBackButton = true,
    this.centerTitle = true,
    this.hasAppBar = true,
    this.canPop = true,
    this.useAppLoader = true,
    this.resizeToAvoidBottomInset = true,
    this.appBarTitle,
    this.trailing,
    this.leading,
    this.body,
    this.scrollChild,
    this.appBar,
    this.floatingActionButtonLocation,
    this.backButtonAction,
    this.hasBottomSafeArea = true,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    Key? key,
  }) : super(key: key);

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.loadingStream,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        return PopScope(
          canPop:  widget.canPop
              ? snapshot.data == true ? false : widget.canPop
              : false,
          onPopInvokedWithResult:(pop, result){
            if(pop){
              widget.backButtonAction?.call();
            }
          },
          child: BlurryModalProgressHUD(
            inAsyncCall: snapshot.data ?? false,
            opacity: 0.5,
            color: Colors.black,
            blurEffectIntensity: 2,
            progressIndicator: Platform.isIOS
                ? CupertinoActivityIndicator(color: Colors.white,)
                : CircularProgressIndicator(color: Colors.white,),
            child: Scaffold(
              backgroundColor: widget.backgroundColor ?? ColorManager.of(context).mainBackground,
              appBar: widget.hasAppBar ? widget.appBar ??
                  AppBar(
                    elevation: 0,
                    title: widget.appBarTitle != null
                        ? Text(
                      widget.appBarTitle!,
                      style: AppTextStyles.medium(
                        context,
                        size: 16,
                        weight: FontWeight.w600,
                      ),
                    )
                        : null,
                    actions: widget.trailing,
                    centerTitle: widget.centerTitle,
                    backgroundColor: widget.appBarColor ?? ColorManager.of(context).mainBackground,
                    leading: widget.leading ?? (widget.hasBackButton
                        ? InkWell(
                      onTap: (){
                        AppRouter.goBack(context);
                        widget.backButtonAction?.call();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back,
                                size: 20,
                                color:widget.backButtonColor ?? ColorManager.of(context).textMain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                        : null
                    ),
                  )
                  : null,
              body: widget.body ?? SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                physics: BouncingScrollPhysics(),
                child: widget.scrollChild,
              ),
              floatingActionButton: widget.floatingActionButton,
              floatingActionButtonLocation: widget.floatingActionButtonLocation ?? FloatingActionButtonLocation.centerDocked,
              resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
              bottomNavigationBar: widget.bottomNavigationBar != null
                  ? widget.hasBottomSafeArea
                  ? SafeArea(child: widget.bottomNavigationBar!)
                  : widget.bottomNavigationBar
                  : null,
            ),
          ),
        );
      },
    );
  }
}
