import org.antlr.v4.runtime.tree.ParseTreeVisitor;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;
import org.antlr.v4.runtime.CharStreams;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class main {
    public static void main(String[] args) throws IOException{

        // we expect exactly one argument: the name of the input file
        if (args.length!=1) {
            System.err.println("\n");
            System.err.println("Impl Interpreter\n");
            System.err.println("=================\n\n");
            System.err.println("Please give as input argument a filename\n");
            System.exit(-1);
        }
        String filename=args[0];

        // open the input file
        CharStream input = CharStreams.fromFileName(filename);
        //new ANTLRFileStream (filename); // depricated

        // create a lexer/scanner
        implLexer lex = new implLexer(input);

        // get the stream of tokens from the scanner
        CommonTokenStream tokens = new CommonTokenStream(lex);

        // create a parser
        implParser parser = new implParser(tokens);

        // and parse anything from the grammar for "start"
        ParseTree parseTree = parser.start();

        // Construct an interpreter and run it on the parse tree
        Interpreter interpreter = new Interpreter();
        Double result=interpreter.visit(parseTree);
        System.out.println("The result is: "+result);
    }
}

// We write an interpreter that implements interface
// "implVisitor<T>" that is automatically generated by ANTLR
// This is parameterized over a return type "<T>" which is in our case
// simply a Double.

class Interpreter extends AbstractParseTreeVisitor<Double> implements implVisitor<Double> {
    // todo - Java will complain that "Interpreter" does not in fact
    // implement "implVisitor" at the moment.

    public Double visitStart(implParser.StartContext ctx){
        System.out.println("Evaluating Start");
        return visit(ctx.e);
    }
    public Double visitAdd(implParser.AddContext ctx){
        Double d1=visit(ctx.e1);
        Double d2=visit(ctx.e2);
        System.out.println("Addition "+d1+ctx.op.getText()+d2);
        if (ctx.op.getText().equals("+"))
            return d1+d2;
        else return d1-d2;
    };
    public Double visitMult(implParser.MultContext ctx){
        Double d1=visit(ctx.e1);
        Double d2=visit(ctx.e2);
        System.out.println("Mult "+d1+ctx.op.getText()+d2);
        if (ctx.op.getText().equals("*"))
            return d1*d2;
        else return d1/d2;
    }
    public Double visitVar(implParser.VarContext ctx){
        System.err.println("Variables not yet supported.");
        System.exit(-1);
        return null;
    };
    public Double visitConst(implParser.ConstContext ctx){
        return Double.valueOf(ctx.f.getText());
    }

    /*
    visitInputs() by Mark Malloy s153679
     */
    @Override
    public String visitInputs(hdl1.InputsContext ctx) {
        StringBuilder inputsToHtml = new StringBuilder("<h2>Inputs</h2>");
        for (TerminalNode input : ctx.IDENTIFIER()) {
            inputsToHtml.append("<p>").append(input.getText()).append("</p>");
        }
        return inputsToHtml.toString();
    }

    /*
    visitUpdates() by Mark Malloy s153679
     */

    @Override
    public String visitOutputs(hdl1.OutputsContext ctx){
        StringBuilder outputsToHtml = new StringBuilder("<h2>Outputs</h2>");
        for(TerminalNode output : ctx.IDENTIFIER()){
            outputsToHtml.append("<p>").append(output.getText()).append("</p>");
        }
        return outputsToHtml.toString();
    }

    //  visitSimulations()
    @Override
    public String visitSimulations(hdl1.SimulationsContext ctx){
        //Simulations has the following grammar definition: '.simulate'  IDENTIFIER '=' BINARY+
        StringBuilder simulationsToHtml = new StringBuilder("<h2>Simulations</h2>");
        for(TerminalNode simulation : ctx.IDENTIFIER()){
            //Take note that we might need to append a String conversion of the Binary which is of type int
            // to the StringBuilder (cast int to string?)
            simulationsToHtml.append("<p>").append(simulation.getText()).append("</p>");
        }
    }





}

