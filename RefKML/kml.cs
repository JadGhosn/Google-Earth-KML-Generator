using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.Configuration;


namespace RefKML
{
    class Kml
    {
        //this will be the contenitor 
        public XmlDocument doc = new XmlDocument();
        //this is Document element
         XmlNode DocumentNode;
         XmlNode kmlNode;

         public Kml()
         {
             
         }

    
        //this function create the frame of the document, it is standard 
        public void GenerateKml()
        {

            XmlNode docNode = doc.CreateXmlDeclaration("1.0", "UTF-8", null);
            doc.AppendChild(docNode);

            kmlNode = doc.CreateElement("kml");

            XmlAttribute xmlnsAttribute = doc.CreateAttribute("xmlns");
            xmlnsAttribute.Value = "http://earth.google.com/kml/2.1";
            kmlNode.Attributes.Append(xmlnsAttribute);
            doc.AppendChild(kmlNode);

            DocumentNode = doc.CreateElement("Document");
            kmlNode.AppendChild(DocumentNode);
        }

        //here we can save the document in a file, so it can be explored with google earth 
        public void SaveKml()
        {
           
            doc.Save(AppDomain.CurrentDomain.BaseDirectory + ConfigurationManager.AppSettings["KMLoutputFileName"].ToString()+".kml");
        }

        //this function can be useful to add a style that can be called by other elements in the document 
        public void AddStyle(string name, string color,string iconcolor,string iconscale,string iconURL,string labelscale)
        {
            XmlNode StyleNode = doc.CreateElement("Style");
            XmlAttribute styleAttribute = doc.CreateAttribute("id");
            styleAttribute.Value = name;
            StyleNode.Attributes.Append(styleAttribute);
            DocumentNode.AppendChild(StyleNode);

            XmlNode IconStyle = doc.CreateElement("IconStyle");
            StyleNode.AppendChild(IconStyle);

            //Icon Color
            XmlNode IconcolorNode = doc.CreateElement("color");
            IconStyle.AppendChild(IconcolorNode);
            IconcolorNode.AppendChild(doc.CreateTextNode(iconcolor));

            //Icon Scale

            XmlNode IconScaleNode = doc.CreateElement("scale");
            IconStyle.AppendChild(IconScaleNode);

            IconScaleNode.AppendChild(doc.CreateTextNode(iconscale));

            //Icon url

            XmlNode IconNode = doc.CreateElement("Icon");
            IconStyle.AppendChild(IconNode);

            XmlNode HrefNode = doc.CreateElement("href");
            IconNode.AppendChild(HrefNode);
            HrefNode.AppendChild(doc.CreateTextNode(iconURL));

            //Label Style
            XmlNode LabelStyle = doc.CreateElement("LabelStyle");
            StyleNode.AppendChild(LabelStyle);

            // Label Scale
            XmlNode LabelScaleNode = doc.CreateElement("scale");
            LabelStyle.AppendChild(LabelScaleNode);
            LabelScaleNode.AppendChild(doc.CreateTextNode(labelscale));

            XmlNode PolyStyleNode = doc.CreateElement("PolyStyle");
            StyleNode.AppendChild(PolyStyleNode);
            XmlNode colorNode = doc.CreateElement("color");
            colorNode.AppendChild(doc.CreateTextNode(color));
            XmlNode outlineNode = doc.CreateElement("outline");
            outlineNode.AppendChild(doc.CreateTextNode("0"));
            PolyStyleNode.AppendChild(colorNode);
            PolyStyleNode.AppendChild(outlineNode);


        }

        //this function can add a point to the map, if you want extend functionalities you have to create other functions for each google earth shapes ( polygon, line, etc... ) 
        public void AddPoint(float lat, float lon, string name,string StyleName,string description)
        {   
            XmlNode PlacemarkNode = doc.CreateElement("Placemark");
            DocumentNode.AppendChild(PlacemarkNode);
            XmlNode nameNode = doc.CreateElement("name");
            nameNode.AppendChild(doc.CreateTextNode(name));
            PlacemarkNode.AppendChild(nameNode);

            XmlNode styleUrlNode = doc.CreateElement("styleUrl");
            styleUrlNode.AppendChild(doc.CreateTextNode("#"+StyleName));
            PlacemarkNode.AppendChild(styleUrlNode);

            XmlNode DescriptionNode = doc.CreateElement("description");
            DescriptionNode.AppendChild(doc.CreateTextNode(description));
            PlacemarkNode.AppendChild(DescriptionNode);


            XmlNode PointNode = doc.CreateElement("Point");
            PlacemarkNode.AppendChild(PointNode);
            XmlNode coordinateNode = doc.CreateElement("coordinates");
            PointNode.AppendChild(coordinateNode);
            coordinateNode.AppendChild(doc.CreateTextNode(lon.ToString(new System.Globalization.CultureInfo("en-US")) + "," + lat.ToString(new System.Globalization.CultureInfo("en-US"))));

        }

        public void AddCPoint(float lat, float lon, string name, string StyleName, string description, string iconcolor, string iconscale, string iconURL,string labelscale,string color)
        {
            XmlNode PlacemarkNode = doc.CreateElement("Placemark");
            DocumentNode.AppendChild(PlacemarkNode);
            XmlNode nameNode = doc.CreateElement("name");
            nameNode.AppendChild(doc.CreateTextNode(name));
            PlacemarkNode.AppendChild(nameNode);

            //from here

            XmlNode StyleNode = doc.CreateElement("Style");
            PlacemarkNode.AppendChild(StyleNode);

            XmlNode IconStyle = doc.CreateElement("IconStyle");
            StyleNode.AppendChild(IconStyle);

            //Icon Color
            XmlNode IconcolorNode = doc.CreateElement("color");
            IconStyle.AppendChild(IconcolorNode);
            IconcolorNode.AppendChild(doc.CreateTextNode(iconcolor));

            //Icon Scale

            XmlNode IconScaleNode = doc.CreateElement("scale");
            IconStyle.AppendChild(IconScaleNode);

            IconScaleNode.AppendChild(doc.CreateTextNode(iconscale));

            //Icon url

            XmlNode IconNode = doc.CreateElement("Icon");
            IconStyle.AppendChild(IconNode);

            XmlNode HrefNode = doc.CreateElement("href");
            IconNode.AppendChild(HrefNode);
            HrefNode.AppendChild(doc.CreateTextNode(iconURL));

            //Label Style
            XmlNode LabelStyle = doc.CreateElement("LabelStyle");
            StyleNode.AppendChild(LabelStyle);

            // Label Scale
            XmlNode LabelScaleNode = doc.CreateElement("scale");
            LabelStyle.AppendChild(LabelScaleNode);
            LabelScaleNode.AppendChild(doc.CreateTextNode(labelscale));

            XmlNode PolyStyleNode = doc.CreateElement("PolyStyle");
            StyleNode.AppendChild(PolyStyleNode);
            XmlNode colorNode = doc.CreateElement("color");
            colorNode.AppendChild(doc.CreateTextNode(color));
            XmlNode outlineNode = doc.CreateElement("outline");
            outlineNode.AppendChild(doc.CreateTextNode("0"));
            PolyStyleNode.AppendChild(colorNode);
            PolyStyleNode.AppendChild(outlineNode);

            //to here

            XmlNode DescriptionNode = doc.CreateElement("description");
            DescriptionNode.AppendChild(doc.CreateTextNode(description));
            PlacemarkNode.AppendChild(DescriptionNode);


            XmlNode PointNode = doc.CreateElement("Point");
            PlacemarkNode.AppendChild(PointNode);
            XmlNode coordinateNode = doc.CreateElement("coordinates");
            PointNode.AppendChild(coordinateNode);
            coordinateNode.AppendChild(doc.CreateTextNode(lon.ToString(new System.Globalization.CultureInfo("en-US")) + "," + lat.ToString(new System.Globalization.CultureInfo("en-US"))));

        }

    
    }
}