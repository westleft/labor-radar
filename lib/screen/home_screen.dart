import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String keyword = '';
  List<Map<String, dynamic>> allData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final String response = await rootBundle.loadString('assets/data.json');
      final List<dynamic> data = json.decode(response);
      setState(() {
        allData = data.cast<Map<String, dynamic>>();
      });
    } catch (e) {
      print('Error loading data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> get filteredData {
    if (keyword.isEmpty) return allData;
    return allData
        .where(
          (item) =>
              (item["事業單位名稱或負責人"]?.toString() ?? '').contains(keyword) ||
              (item["違反法規內容"]?.toString() ?? '').contains(keyword),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: '搜尋事業單位或負責人',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    keyword = value;
                  });
                },
              ),
            ),
            Expanded(
              child: isLoading
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16.h),
                          Text('載入資料中...'),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        final item = filteredData[index];
                        return Card(
                          margin: EdgeInsets.only(bottom: 16.h),
                          child: Padding(
                            padding: EdgeInsets.all(12.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["事業單位名稱或負責人"]?.toString() ?? '',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text("違規內容：${item["違反法規內容"]?.toString() ?? ''}"),
                                SizedBox(height: 4.h),
                                Text("公告日期：${item["公告日期"]?.toString() ?? ''}"),
                                SizedBox(height: 4.h),
                                Text("處分日期：${item["處分日期"]?.toString() ?? ''}"),
                                SizedBox(height: 4.h),
                                Text("處分字號：${item["處分字號"]?.toString() ?? ''}"),
                                SizedBox(height: 4.h),
                                Text("處分金額：\$${item["處分金額或滯納金"]?.toString() ?? ''}"),
                                if (item["備註說明"]?.toString().isNotEmpty == true) ...[
                                  SizedBox(height: 4.h),
                                  Text("備註：${item["備註說明"]?.toString() ?? ''}"),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
