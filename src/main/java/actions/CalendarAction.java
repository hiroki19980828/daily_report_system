package actions;

import java.io.IOException;
import java.util.List; //追記

import javax.servlet.ServletException;

import actions.views.EmployeeView; //追記
import actions.views.ReportView; //追記
import constants.AttributeConst;
import constants.ForwardConst;
import services.ReportService;  //追記

/**
 * トップページに関する処理を行うActionクラス
 *
 */
public class CalendarAction extends ActionBase {

    private ReportService service; //追記

    /**
     * indexメソッドを実行する
     */
    @Override
    public void process() throws ServletException, IOException {

        service = new ReportService(); //追記

        //メソッドを実行
        invoke();

        service.close(); //追記

    }

    /**
     * イベントを取得する
     */
    public void calendar() throws ServletException, IOException {

        // 以下追記

        //セッションからログイン中の従業員情報を取得
        EmployeeView loginEmployee = (EmployeeView) getSessionScope(AttributeConst.LOGIN_EMP);

        //ログイン中の従業員が作成した日報データを、指定されたページ数の一覧画面に表示する分取得する
        List<ReportView> reports = service.getMinePerPage(loginEmployee);

        //ログイン中の従業員が作成した日報データの件数を取得
        long myReportsCount = service.countAllMine(loginEmployee);

        putRequestScope(AttributeConst.REPORTS, reports); //取得した日報データ
        putRequestScope(AttributeConst.REP_COUNT, myReportsCount); //ログイン中の従業員が作成した日報の数
        //カレンダー画面を表示
        forward(ForwardConst.FW_REP_CALENDAR);
    }

}
