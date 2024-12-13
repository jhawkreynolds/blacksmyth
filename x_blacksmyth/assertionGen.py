import sys, inspect, importlib.util, itertools, random

def generate_variations(bound, length):
    variations = list(itertools.product(range(bound+1), repeat=length))
    #ret = []
    #for v in variations: ret.append(list(v))
    #return ret
    return variations

def generate_upto_variations(bound, length):
    variations = []
    for i in range(length+1):
        variations += generate_variations(bound,i)
    return variations

def gen_sample(bound, length, sample_rate, sample_bound):
    variations = []
    for i in range(length+1):
        vary = generate_variations(bound,i)
        if( i >= sample_bound): vary = random.sample(vary, sample_rate)
        variations += vary
    return variations

# These functions determine what assertions get made
def gen_NatList():
    return gen_sample(3,8,2,3)

def gen_Nat():
    return range(0,4)

def import_module_from_path(module_name, file_path):
    try:
        spec = importlib.util.spec_from_file_location(module_name, file_path)
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        return module
    except Exception as e:
        print(f"Error loading module {module_name} from {file_path}: {e}")
        return None
    
def typeSig(params):
    type_sig = []
    for param in params:
        typ = params[param].annotation
        if typ == int: type_sig.append((param, "Nat"))
        elif typ == list[int]: type_sig.append((param, "NatList"))
        else: type_sig.append((param, "Undefined"))
    return type_sig

def gen_output(func, typeSig):
    inp = []
    for param in typeSig:
        type = param[1]
        if type == 'Nat': inp.append(gen_Nat())
        elif type == 'NatList': inp.append(gen_NatList())
        else: inp.append([])

    inpShort = []
    for v in inp:
        inpShort.append(v[:4])

    first = list(itertools.product(*inpShort))
    long = list(itertools.product(*inp))
    inputs = list(set(random.sample(long, 10) + first))

    outputs = []
    for inp in inputs:
        out = func(*inp)
        outputs.append(inp + (out, ))
    
    return outputs

def print_List_Assertion(ls):
    print('[', end='')
    for i in range(len(ls)):
        print(str(ls[i]), end='')
        if i >= (len(ls)-1): continue
        print('; ', end='')
    print(']', end='')

def print_Assertions(output, module_name):
    print()
    print("specifyFunction" + str(len(output[0])-1) + " " + module_name + "[" , end="")
    for i, out in enumerate(output):
        print('(', end='')
        for j, o in enumerate(out):
            if type(o) == tuple:
                print_List_Assertion(list(o))
            else:
                print(o, end='')
            
            if j >= (len(out)-1): continue
            print(', ', end='')

        print(')', end='')
        if i >= (len(output)-1): continue
        print(', ', end='')
    print(']')

if(len(sys.argv) < 2): 
    quit()

input_file = sys.argv[1]
module_name = input_file.split('/')[-1].split('.')[0]

module = import_module_from_path(module_name, input_file)

func = module.oracle
function_sig = inspect.signature(func)
params = function_sig.parameters

output = gen_output(func, typeSig(params))
print_Assertions(output, module_name)