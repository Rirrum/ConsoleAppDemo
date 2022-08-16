package demo;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.util.Scanner;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.*;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.xml.sax.InputSource;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;

import ca.uhn.hl7v2.DefaultHapiContext;
import ca.uhn.hl7v2.HL7Exception;
import ca.uhn.hl7v2.HapiContext;
import ca.uhn.hl7v2.model.Message;
import ca.uhn.hl7v2.model.v28.message.ADT_A01;
import ca.uhn.hl7v2.model.v28.message.ADT_A02;
import ca.uhn.hl7v2.parser.CanonicalModelClassFactory;
import ca.uhn.hl7v2.parser.PipeParser;
import ca.uhn.hl7v2.parser.XMLParser;

/**
 * Hello world!
 */
public final class App {
    private static boolean validate(String hl7) {
        boolean result = true;
        try {
            // Process pr = Runtime.getRuntime().exec("java -jar ./validator_cli.jar ./tempoutput.json");
            // Link to code found: https://stackoverflow.com/questions/1732455/redirect-process-output-to-stdout
            File output = new File("./cmdoutput.txt");
            ProcessBuilder pb = new ProcessBuilder("java", "-jar", "./validator_cli.jar", "./tempoutput.json");
            pb.directory(new File("C:\\Users\\t-wyuan\\Microsoft Internship\\XSLT\\Demo\\demo\\src\\main\\java\\demo"));
            pb.inheritIO();
            pb.redirectOutput(output);
            Process p = pb.start();
            p.waitFor();

            // Can't write to cmdoutput.txt for some reason
            Scanner sc = new Scanner(output);
            // FileWriter writer = new FileWriter(output);
            String s = "";
            while (sc.hasNextLine()) {
                s = sc.nextLine();
                // writer.write(s);
                if (s.contains("FAILURE")) result = false;
                System.out.println(s);
            }
            sc.close();
            // pb.redirectError(Redirect.INHERIT)
        }
        catch (IOException e) {
            e.printStackTrace();
        }
        catch (InterruptedException e) {
            e.printStackTrace();
        }

        return result;
    }

    /**
     * Parses the message type from an HL7v2 message
     * @param hl7 - Hl7v2 message
     * @return - String representing message type (ex ADT_A01)
     */

    public static String getMessageType(String hl7) {
        int pipeIndex = hl7.indexOf("|");
        for (int _i = 0; _i < 7; _i++) {
            int next = hl7.indexOf("|", pipeIndex + 1);
            pipeIndex = next;
        }
        return hl7.substring(pipeIndex + 1, pipeIndex + 8).replace('^', '_');
    }

    private static String parseHL7(String hl7) {
        HapiContext hapiContext = new DefaultHapiContext();
        CanonicalModelClassFactory mcf = new CanonicalModelClassFactory("2.8");
        hapiContext.setModelClassFactory(mcf);
        hapiContext.getParserConfiguration().setValidating(false);

        try {
            PipeParser parser = hapiContext.getPipeParser();
            Message message = parser.parse(hl7);
            String messageType = getMessageType(hl7);
            XMLParser xmlParser = hapiContext.getXMLParser();
            String xmlPayload;

            switch (messageType) {
                case "ADT_A01":
                    ADT_A01 a01message = (ADT_A01) message;
                    xmlPayload = xmlParser.encode(a01message);
                    break;
                case "ADT_A02":
                    ADT_A02 a02message = (ADT_A02) message;
                    xmlPayload = xmlParser.encode(a02message);
                    break;
                default:
                    xmlPayload = "empty";
                    break;
            }
            
            return xmlPayload;
        } catch (HL7Exception e) {
            return "hl7exception";
        }
    }

    private static void convert(String xml) {
        // First, convert the string to the xml file
        try {
            DocumentBuilderFactory fac = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = fac.newDocumentBuilder();
            builder.parse(new InputSource(new StringReader(xml)));
        } catch (Exception e) {
            e.printStackTrace();
        }
       

        // Now to use the file to apply the conversion to
        try {
            TransformerFactory factory = TransformerFactory.newInstance();
            // This file is for the .xsl file, make sure to reference the correct folder/path and correct file
            Source xslt = new StreamSource(new File("C:\\Users\\t-wyuan\\Microsoft Internship\\XSLT\\Demo\\demo\\src\\main\\java\\demo\\Templates\\ADT_A01.xsl")); 
            Transformer transformer = factory.newTransformer(xslt);

            // This file is the input .xml file that you want to transform
            Source text = new StreamSource(new File("C:\\Users\\t-wyuan\\Microsoft Internship\\XSLT\\Demo\\demo\\src\\main\\java\\demo\\tempinput.xml"));
            // This is for the transformation and saving the output, make sure to put the correct path/file and to adjust the file extension as necessary
            transformer.transform(text, new StreamResult(new File("C:\\Users\\t-wyuan\\Microsoft Internship\\XSLT\\Demo\\demo\\src\\main\\java\\demo\\tempoutput.json")));
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        
    }

    private static String getHL7(String file) {
        try {
            Scanner scr = new Scanner(new File(file));
            String message = "";
            String line = null;
    
            while (scr.hasNextLine()) {
                line = scr.nextLine();
                message += line;
            }
            return message;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "Failed to get message";
    }

    public static void main(String[] args) {
        String hl7 = getHL7("C:\\Users\\t-wyuan\\Microsoft Internship\\XSLT\\Demo\\demo\\src\\main\\java\\demo\\message.hl7");
        System.out.println(hl7);
        String xml = parseHL7(hl7);
        // System.out.println(xml);

        // validate("hi");        
    }
}
