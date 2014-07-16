using System;
using System.Configuration;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;
using System.Data.OleDb;
using System.Collections;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

using System.Threading;
//using GeoCoding;
//using  GeoCoding.Google;
using Excel = Microsoft.Office.Interop.Excel;
using GoogleMapsApi;
using GoogleMapsApi.Entities.Common;
using GoogleMapsApi.Entities.Directions.Request;
using GoogleMapsApi.Entities.Directions.Response;
using GoogleMapsApi.Entities.Elevation.Request;
using GoogleMapsApi.Entities.Geocoding.Request;
using GoogleMapsApi.Entities.Geocoding.Response;
using GoogleMapsApi.StaticMaps;
using GoogleMapsApi.StaticMaps.Entities;
using System.Web;
using System.Xml.Linq;

using System.Net;
using System.Xml;



namespace RefKML
{
    public partial class AppForm : Form
    {
    
         public AppForm()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            //Loads the Default Country code from configuration file
            LoadConfiguration();

         
        }

   

        private void LoadConfiguration()
        {
            comboBoxLatitude.Text = "Latitude";
            comboBoxLongitude.Text = "Longitude";
            comboBoxMainItem.Text = "Location";
            textBoxDefaultLongitude.Text = ConfigurationManager.AppSettings["DefaultLongitude"].ToString();
            textBoxDefaultLatitude.Text = ConfigurationManager.AppSettings["DefaultLatitude"].ToString();
            textBoxKMLoutputFile.Text = ConfigurationManager.AppSettings["KMLoutputFileName"].ToString();
            
            textBoxLabelURL.Text = ConfigurationManager.AppSettings["DefaultIconURL"].ToString();

        }

     
        private void button1_Click(object sender, EventArgs e)
        {
         
                GenerateKMLFromExcel();
            
        }
        private void GenerateKMLFromExcel()
        {
            try
            {

                Kml MyKml = new Kml();
                MyKml.GenerateKml();
                MyKml.AddStyle("Jad", "RED", textBoxIconColor.Text, textBoxIconSize.Text, textBoxLabelURL.Text, textBoxLabelSize.Text);
                string description = "";
                for (int i = 0; i < this.MydataGrid.Rows.Count - 1; i++)
                {
                    DataGridViewRow row = this.MydataGrid.Rows[i];

                    float Lon = float.Parse(row.Cells[comboBoxLongitude.Text].Value.ToString()); //make dynamic
                    float Lat = float.Parse(row.Cells[comboBoxLatitude.Text].Value.ToString()); //make dynamic
                    string labelURL = "";
                    description = textBoxDescription.Text.Replace("#date", DateTime.Now.ToShortDateString());
                    foreach (object x in listBox3.Items)
                    {
                        description = description.Replace
                            (x.ToString(), row.Cells[x.ToString().Replace("#", "")].Value.ToString());
                        labelURL = textBoxLabelURL.Text.
                            Replace(x.ToString(), row.Cells[x.ToString().Replace("#", "")].Value.ToString());
                    }

                    //double IconSize = (Persons * (double.Parse(textBoxMaxIconSize.Text))) / MaxPersons;
                    double IconSize = double.Parse(textBoxMaxIconSize.Text);
                    if (IconSize < double.Parse(textBoxMinIconSize.Text)) IconSize = double.Parse(textBoxMinIconSize.Text);
                    IconSize = Math.Round(IconSize, 1);
                    string Location = row.Cells[comboBoxMainItem.Text].Value.ToString(); //Make it dynamic
                    string DateToday = DateTime.Now.ToShortDateString();

                    if (checkBoxDynamicIcon.Checked)
                        MyKml.AddCPoint(Lat, Lon, Location, "Jad", description, textBoxIconColor.Text, IconSize.ToString(), labelURL, textBoxLabelSize.Text, textBoxLabelColor.Text);
                    else
                        MyKml.AddPoint(Lat, Lon, Location, "Jad", description);

                }
                MyKml.SaveKml();

                MessageBox.Show("Done creating KML - Google earth will open now");
                System.Diagnostics.Process.Start(AppDomain.CurrentDomain.BaseDirectory + ConfigurationManager.AppSettings["KMLoutputFileName"].ToString() + ".kml");
            }
            catch (Exception ex)
            {
                textBox1.Text = textBox1.Text + " " + ex.Message;
            }
        }
   
        int max_array(int []a, int num_elements)
        {
           int i, max=-32000;
           for (i=0; i<num_elements; i++)
           {
	         if (a[i]>max)
	         {
	            max=a[i];
	         }
           }
           return(max);

        }

            private void checkBoxDynamicIcon_CheckedChanged(object sender, EventArgs e)
        {
            if (checkBoxDynamicIcon.Checked)
                panel1.Enabled = true;
            else
                panel1.Enabled = false;
        }

   

             private void groupBox3_Enter(object sender, EventArgs e)
        {

        }

        private void button4_Click(object sender, EventArgs e)
        {
            MessageBox.Show("You will need to edit the chart API script with real values in order to display properly");
            string PieChartText = @"<img src=""http://chart.apis.google.com/chart?cht=p&chd=t:DataValue&chdl=legend&chl=datalabel&chs=200x200&chf=bg,s,ffffff00&chco=FF7800,007800""/>";

            int DataValues = int.Parse(textBoxPieSlices.Text);
            while (DataValues != 0)
            {
                PieChartText=PieChartText.Replace("DataValue", "DataValue,#" + DataValues.ToString());
                PieChartText = PieChartText.Replace("legend", "legend|Lgnd" + DataValues.ToString());
                PieChartText = PieChartText.Replace("datalabel", "datalabel|DataLbl" + DataValues.ToString());
                DataValues--;
            }
            PieChartText = PieChartText.Replace("DataValue,", "");
            PieChartText = PieChartText.Replace("legend|", "");
            PieChartText = PieChartText.Replace("datalabel|","");

           

            
            textBoxDescription.Text = textBoxDescription.Text + "\r\n" + "\r\n" + PieChartText;
        }

        //Age Gender Chart
        private void button6_Click(object sender, EventArgs e)
        {
            string BarChartText = @"<img src=""http://chart.apis.google.com/chart?chxl=0:|60%2B|18-59|12-17|5-11|0-4&chxr=0,0,160|1,0,#max&chxt=y,x&chbh=a&chs=440x220&cht=bhg&chco=4D89F9,C6D9FD&chds=0,#max,0,#max&chd=t:#F0_4,#F5_11,#F12_17,#F18_59,#F60_plus|#M0_4,#M5_11,#M12_17,#M18_59,#M60_plus&chdl=Female|Male&chtt=Age+Gender+Breakdown"" width=""440"" height=""220""/>";

            textBoxDescription.Text = textBoxDescription.Text + "\r\n" + "\r\n" + BarChartText;
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void tabPage3_Click(object sender, EventArgs e)
        {

        }

      

        private void tabPage2_Click(object sender, EventArgs e)
        {

        }

        private void label14_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click_1(object sender, EventArgs e)
        {
       

            ConfigUpdate.ChangeConfig("DefaultLongitude", textBoxDefaultLongitude.Text);
            ConfigUpdate.ChangeConfig("DefaultLatitude", textBoxDefaultLatitude.Text);

            ConfigUpdate.ChangeConfig("KMLoutputFileName", textBoxKMLoutputFile.Text);

            MessageBox.Show("Saved");

        }

        private void textBox3_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBoxServer_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBoxUser_TextChanged(object sender, EventArgs e)
        {

        }

        private void tabPage1_Click(object sender, EventArgs e)
        {

        }

        private void label13_Click(object sender, EventArgs e)
        {

        }

    
        private void textBoxDescription_DragOver(object sender, DragEventArgs e)
        {
            e.Effect = DragDropEffects.All;
        }

        private void textBoxDescription_DragDrop(object sender, DragEventArgs e)
        {
            if(e.Data.GetDataPresent(DataFormats.StringFormat))
    { 
        string str= (string)e.Data.GetData(
            DataFormats.StringFormat);
           
            textBoxDescription.Text+=str; 
    }
        }

    
           private void groupBox7_Enter(object sender, EventArgs e)
        {

        }

        private void groupBox11_Enter(object sender, EventArgs e)
        {

        }

        private void tabPage4_Click(object sender, EventArgs e)
        {

        }

        private void button9_Click(object sender, EventArgs e)
        {
            OpenFileDialog fdlg = new OpenFileDialog();
            fdlg.Title = "Select file";
            fdlg.InitialDirectory = @"c:\";
            fdlg.FileName = txtFileName.Text;
            fdlg.Filter = "Excel Sheet(*.xls)|*.xls|All Files(*.*)|*.*";
            fdlg.FilterIndex = 1;
            fdlg.RestoreDirectory = true;
            if (fdlg.ShowDialog() == DialogResult.OK)
            {
                txtFileName.Text = fdlg.FileName;
             
                ProcessExcel(txtFileName.Text);
                Application.DoEvents();
            }
        }
  

     

        private void ProcessExcel(string filepath)
    {

            Excel.Application ExcelObj = new Excel.Application();

            Excel.Workbook theWorkbook = ExcelObj.Workbooks.Open(filepath, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing);

            Excel.Sheets sheets = theWorkbook.Worksheets;

            Excel.Worksheet worksheet = (Excel.Worksheet)sheets.get_Item(1);

            Excel.Range range = worksheet.UsedRange;

            System.Array myvalues = (System.Array)range.Cells.Value2;

            int vertical = myvalues.GetLength(0);
            int horizontal = myvalues.GetLength(1);



            string[] headers = new string[horizontal];
            string[] data = new string[horizontal];


            DataTable ResultsHeader = new DataTable();
            DataSet ds = new DataSet();


            for (int x = 1; x <= vertical; x++)
            {
              //    Utils.inicializarArrays(datos);
                    for (int y = 1; y <= horizontal; y++)
                    {
                        if (x == 1)
                        {
                            headers[y - 1] = myvalues.GetValue(x, y).ToString();
                        }
                        else
                        {
                            string auxdata = "";
                            if (myvalues.GetValue(x, y) != null)
                                auxdata = myvalues.GetValue(x, y).ToString();
                            data[y - 1] = auxdata;
                        }

                    }
                    if(x == 1) //headers
                    {
                            for(int w = 0; w < horizontal; w++)
                            {
                                    ResultsHeader.Columns.Add(new DataColumn(headers[w]));
                                    listBox3.Items.Insert(0, '#' + headers[w].ToString());
                                    comboBoxMainItem.Items.Insert(0,  headers[w].ToString());
                                    comboBoxLatitude.Items.Insert(0,  headers[w].ToString());
                                    comboBoxLongitude.Items.Insert(0,  headers[w].ToString());
                                    
                            }
                            ds.Tables.Add(ResultsHeader);
                            comboBoxMainItem.SelectedIndex = 0;
                    }
                    else
                    {
                            DataRow dataRow = ds.Tables[0].NewRow();
                        
                            for(int w = 0; w < horizontal; w++)
                            {
                                   dataRow[headers[w]] = data[w];
                            }
                            ds.Tables[0].Rows.Add(dataRow);
                    }
            }
            DataView myDataView = new DataView();
            myDataView.Table = ds.Tables[0];
          //  MydataGrid.CurrentPageIndex = 0;
            MydataGrid.DataSource = myDataView;
            //MydataGrid.DataBind();
    }

     

        private void MydataGrid_DoubleClick(object sender, EventArgs e)
        {
            try
            {
                textBoxAddresstoCode.Text =
              MydataGrid.SelectedCells[1].Value.ToString()
                    + " " + MydataGrid.SelectedCells[2].Value.ToString()
                    + " " + MydataGrid.SelectedCells[3].Value.ToString()
                    + " " + MydataGrid.SelectedCells[5].Value.ToString();
            }
            catch (Exception Ex)
            {
                //MessageBox.Show("An Error Has Occured: " + Ex.Message);
            }
        }

        private void ExportToExcel()
        {
            Microsoft.Office.Interop.Excel.Application wapp;

            Microsoft.Office.Interop.Excel.Worksheet wsheet;
            Microsoft.Office.Interop.Excel.Workbook wbook;
            wapp = new Microsoft.Office.Interop.Excel.Application();
            wapp.Visible = false;
            wbook = wapp.Workbooks.Add(true);
            wsheet = (Microsoft.Office.Interop.Excel.Worksheet)wbook.ActiveSheet;
            try
            {
                int iX;
                int iY;
                for (int i = 0; i < this.MydataGrid.Columns.Count; i++)
                {
                    wsheet.Cells[1, i + 1] = this.MydataGrid.Columns[i].HeaderText;
                   
                }
                for (int i = 0; i < this.MydataGrid.Rows.Count; i++)
                {
                    DataGridViewRow row = this.MydataGrid.Rows[i];
                    for (int j = 0; j < row.Cells.Count; j++)
                    {
                        DataGridViewCell cell = row.Cells[j];
                        try
                        {
                            wsheet.Cells[i + 2, j + 1] = (cell.Value == null) ? "" : cell.Value.ToString();
                        }
                        catch (Exception ex)
                        {
                            MessageBox.Show(ex.Message);
                        }
                    }
                }
                wapp.Visible = true;
            }
            catch (Exception ex1)
            {
                MessageBox.Show(ex1.Message);
            }

        }

        private void button10_Click(object sender, EventArgs e)
        {
            Thread T = new Thread(new ThreadStart(AutoGeoCodeAndExport));
            T.Start();
        }
        private void AutoGeoCodeAndExport()
        {
            if (!MydataGrid.Columns.Contains("Longitude"))
            {
                MydataGrid.Columns.Add("Longitude", "Longitude");
                comboBoxLongitude.Items.Insert(0, "Latitude");
                comboBoxLatitude.Items.Insert(0, "Longitude");
                comboBoxLongitude.Items.Insert(0, "Longitude");
                comboBoxLatitude.Items.Insert(0, "Latitude");
                

            }
            if (!MydataGrid.Columns.Contains("Latitude"))
            {
                MydataGrid.Columns.Add("Latitude", "Latitude");

            }
        
            for (int i = 0; i < this.MydataGrid.Rows.Count - 1; i++)
            {
                DataGridViewRow row = this.MydataGrid.Rows[i];
                string texttogecode = "";
                int cnt = int.Parse(textFieldsToGeocode.Text);
                for (int j = 0; j < cnt; j++)
                {
                    texttogecode += row.Cells[j].Value.ToString() + " ";
                }
            var GeocodeRequest =new GeocodingRequest();
            GeocodeRequest.Address=texttogecode;

            var task= GoogleMaps.Geocode.Query(GeocodeRequest);
            if (task.Results.Count() > 0)
            {
                row.Cells["Longitude"].Value = task.Results.First().Geometry.Location.Longitude.ToString();
                row.Cells["Latitude"].Value = task.Results.First().Geometry.Location.Latitude.ToString();
            }
            else
            {
                row.Cells["Longitude"].Value = -1;
                row.Cells["Latitude"].Value = -1;
            }

           
        }

        //    ExportToExcel();
        }
        private void AddElevationAndExport()
        {
            if (!MydataGrid.Columns.Contains("Elevation"))
            {
                MydataGrid.Columns.Add("Elevation", "Elevation");
               
            }
          
            for (int i = 0; i < this.MydataGrid.Rows.Count - 1; i++)
            {
                    DataGridViewRow row = this.MydataGrid.Rows[i];
                    double latitude = double.Parse(row.Cells["latitude"].Value.ToString());
                    double longitude = double.Parse(row.Cells["longitude"].Value.ToString());
                
                if (row.Cells["Elevation"].Value == null)
                {
                    row.Cells["Elevation"].Value = GetElevation(latitude, longitude);
                }
                else
                    if (row.Cells["Elevation"].Value.ToString() == "-1000" )
                    {
                  
                        row.Cells["Elevation"].Value = GetElevation(latitude, longitude);
                    }
                   
                }
            MessageBox.Show("Done GeoCoding Elevation");
            }
      
            
            // Gets Elevation
            private string GetElevation(double latitude, double longitude)
            {
                try
                {
                    var elevationRequest = new ElevationRequest
               {
                   Locations = new[] { new Location(latitude, longitude) },
               };

                    var task = GoogleMaps.Elevation.Query(elevationRequest);
                    if (task.Results.Count() > 0)
                    {
                        return task.Results.First().Elevation.ToString();

                    }
                    else
                    {
                        return "-1000";
                    }
                }
                catch (Exception ex)
                {
                    return "-1000";
                }
            }

         

        private void listBox3_MouseDown(object sender, MouseEventArgs e)
        {
            if (listBox3.Items.Count == 0)
                return;

            int index = listBox3.IndexFromPoint(e.X, e.Y);
            string s = listBox3.Items[index].ToString();
            DragDropEffects dde1 = DoDragDrop(s,
                DragDropEffects.All);

            if (dde1 == DragDropEffects.All)
            {
                //listBox2.Items.RemoveAt(listBox2.IndexFromPoint(e.X, e.Y));
            } 
        }

        private void button10_Click_1(object sender, EventArgs e)
        {
            Thread T = new Thread(new ThreadStart(AddElevationAndExport));
            T.Start();
        }

        private void button11_Click(object sender, EventArgs e)
        {
            ExportToExcel();
        }

        private void listBox2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void button12_Click(object sender, EventArgs e)
        {
            Thread T = new Thread(new ThreadStart(AutoAddLocationAndExport));
            T.Start();
        }


        private void AutoAddLocationAndExport()
        {
            try
            {
                

                for (int i = 0; i < this.MydataGrid.Rows.Count - 1; i++)
                {
                    DataGridViewRow row = this.MydataGrid.Rows[i];
                    string lat = row.Cells["Latitude"].Value.ToString();
                    string lng = row.Cells["Longitude"].Value.ToString();
                    string url = @"http://maps.googleapis.com/maps/api/geocode/json?latlng=" + lat.ToString() + "," + lng.ToString() + @"&sensor=false&language=ar";
                    //  string url = @"http://maps.googleapis.com/maps/api/geocode/json?latlng=" + textBoxLatitudeExcel.Text+ "," + textBoxLongitudeExcel.Text + @"&sensor=false&language=AR";
                    string returnvalue = CallURL(url);
                    JObject o = JObject.Parse(returnvalue);
                    if (!MydataGrid.Columns.Contains("JsonDescription"))
                    {
                        MydataGrid.Columns.Add("JsonDescription", "JsonDescription");
                    }
                    row.Cells["JsonDescription"].Value = returnvalue;

                    foreach (var node in o["results"])
                    {
                        int nodescnt = node.Count();
                        int j = 0;

                        while (j < nodescnt)
                        {
                            try
                            {
                                int childcnt = o["results"][j]["address_components"].Children().Count();
                                int x = 0;
                                while (x < childcnt)
                                {
                                    try
                                    {
                                        if (o["results"][j]["address_components"][x]["types"].ToString().Contains("administrative_area_level_3"))
                                        {
                                            if (!MydataGrid.Columns.Contains("autoAdminLevel3_" + j.ToString()))
                                            {
                                                MydataGrid.Columns.Add("autoAdminLevel3_" + j.ToString(), "autoAdminLevel3_" + j.ToString());
                                            }
                                            row.Cells["autoAdminLevel3_" + j.ToString()].Value = o["results"][j]["address_components"][x]["long_name"].ToString();
                                        }
                                    }
                                    catch (Exception ex)
                                    {
                                    }
                                    x++;
                                }
                            }
                            catch (Exception ex)
                            {
                            }
                                j++;
                        }
                    }
                

                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }


        }
        private string CallURL(string curl)
        {
            string result;
            using (var client = new WebClient())
            {
                client.Encoding = Encoding.UTF8;
                 result = client.DownloadString(curl);
            }
            return result;

            //HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create(curl);
            //using (HttpWebResponse response = (HttpWebResponse)webRequest.GetResponse())
            //{
            //    using (Stream resStream = response.GetResponseStream())
            //    {
            //        StreamReader reader = new StreamReader(resStream, Encoding.Unicode);
            //        return reader.ReadToEnd();
            //    }
            //}
        }

        private void label6_Click(object sender, EventArgs e)
        {

        }



            //    ExportToExcel();
        }
      
           

       
}
       

   

       

