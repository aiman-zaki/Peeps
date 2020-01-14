import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:peeps/global/chart.dart';
import 'package:peeps/screens/common/tag.dart';
import '../splash_page.dart';

class UsersGrowthCharts extends StatelessWidget {
  const UsersGrowthCharts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _usersBloc = BlocProvider.of<AdminUsersBloc>(context);
    final _usersChartsBloc = BlocProvider.of<AdminDashboardBloc>(context);
    List<Widget> _usersGrowth(){
      return [
          Container(
            child: BlocBuilder(
              bloc:_usersBloc,
              builder: (context,state){
                if(state is LoadedAdminUsersState){
                  _usersChartsBloc.add(GenerateAdminDashboard(data: state.data));
                  return BlocBuilder(
                    bloc:_usersChartsBloc,
                    builder: (context,chartState){
                      if(chartState is InitialAdminUsersState){
                        return SplashScreen();
                      }
                      if(chartState is GeneratingAdminDashboardState){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      if(chartState is GeneratedAdminDashboardState){
                        var series = [
                          new charts.Series<UsersGrowthPerYear,String>(
                            id:"UsersGrowth",
                            domainFn: (UsersGrowthPerYear data,_) => data.year,
                            measureFn: (UsersGrowthPerYear data,_) => data.no,
                            colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
                            data: chartState.data['joined'],
                          )
                        ];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CustomTag(color: Colors.blue,text: Text("Active users this week : ${chartState.data['active_user'][0]['last_logined'].toString()}"),padding: EdgeInsets.all(9),),
                            CustomTag(color: Colors.green,text: Text("Users Growth"),padding: EdgeInsets.all(9),),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 200,
                                  child: new charts.BarChart(
                                    series,
                                    animate: true,
                                    domainAxis: new charts.OrdinalAxisSpec(
                                      renderSpec: new charts.SmallTickRendererSpec(
                                        labelStyle: new charts.TextStyleSpec(
                                          fontSize: 18, // size in Pts.
                                          color: charts.MaterialPalette.white),
                                      )
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
          ),
      ];
    }
    return Column(
      children: _usersGrowth(),
    );
  }
}